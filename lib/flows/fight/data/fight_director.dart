import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/attribute_probability_calculator.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/damage_calculator.dart';
import 'package:alpaka_clicker/base/randomizer/dice_roller.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/health_calculator.dart';
import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:alpaka_clicker/flows/fight/data/turn_result.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/turn_type.dart';
import 'package:injectable/injectable.dart';

@injectable
class FightDirector {
  final Character player;
  final DiceRoller diceRoller;
  final DamageCalculator damageCalculator;
  final HealthCalculator healthCalculator;
  final AttributeProbabilityCalculator probabilityCalculator;
  final int fullHealth;

  FightDirector(
    this.player,
    this.diceRoller,
    this.damageCalculator,
    this.healthCalculator,
    this.probabilityCalculator,
    @Named("fullHealth") this.fullHealth,
  ) {
    playerProbability = probabilityCalculator.calculateProbability(player);
  }

  late final Probability<AttributeTag> playerProbability;

  Character? _enemy;
  late Probability<AttributeTag> _enemyProbability;

  int _round = 0;

  int get round => _round;

  int _playerDamageTaken = 0;

  int get playerDamageTaken => _playerDamageTaken;

  int _enemyDamageTaken = 0;

  int get enemyDamageTaken => _enemyDamageTaken;

  void startWithNewEnemy(Character enemy) {
    _round = 0;
    _enemy = enemy;
    _enemyProbability = probabilityCalculator.calculateProbability(enemy);
    _enemyDamageTaken = 0;
  }

  TurnResult makeTurn() {
    if (_enemy == null) {
      throw ArgumentError("Enemy is null, TODO make unique exception");
    } else if (_round++ % 2 == 0) {
      return playerTurn();
    } else {
      return enemyTurn();
    }
  }

  TurnResult playerTurn() {
    return playOutTurn(player, playerProbability, _enemy!, _enemyProbability, TurnType.player);
  }

  TurnResult enemyTurn() {
    return playOutTurn(_enemy!, _enemyProbability, player, playerProbability, TurnType.enemy);
  }

  TurnResult playOutTurn(Character attacker, Probability<AttributeTag> attackerProbability, Character defender,
      Probability defenderProbability, TurnType type) {
    final attackerAttributeTag = diceRoller.roll(attackerProbability);
    final defenderAttributeTag = diceRoller.roll(defenderProbability);
    final damage = damageCalculator.calculateDamage(
        attacker.getAttributeByTag(attackerAttributeTag), defender.getAttributeByTag(defenderAttributeTag));
    giveDamageToCorrectFighter(type, damage);
    return TurnResult(
        type: type,
        attackerName: attacker.name,
        attackAttribute: attackerAttributeTag,
        defenderName: defender.name,
        defendAttribute: defenderAttributeTag,
        damageDealt: damage,
        playerHealth: healthCalculator.calculateHealth(damageTaken: _playerDamageTaken, fullHealth: fullHealth),
        enemyHealth: healthCalculator.calculateHealth(damageTaken: _enemyDamageTaken, fullHealth: fullHealth));
  }

  void giveDamageToCorrectFighter(TurnType type, int damage) {
    if (type == TurnType.player) {
      _enemyDamageTaken += damage;
    } else {
      _playerDamageTaken += damage;
    }
  }
}
