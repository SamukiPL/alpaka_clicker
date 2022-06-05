import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/fight/data/fight_director.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/turn_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../testUtils/dummy_mocks.dart';
import '../../../testUtils/mocked_models.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  final player = emptyCharacter();
  final enemy = emptyCharacter();
  final damageCalculator = MockDamageCalculator();
  final healthCalculator = MockHealthCalculator();
  final probabilityCalculator = MockAttributeProbabilityCalculator();
  const fullHealth = 10;

  const returnedTag = AttributeTag.rock;
  final probability = Probability(1, {1: returnedTag});

  const damageTaken = 1;
  final returnedHealth = HealthModel(1, "displayableHealth");
  final diceRoller = MockDiceRoller(dummyReturn: <T>(prob) => prob.attributesProp.values.first);

  setUpAll(() {
    resetMockitoState();
    when(probabilityCalculator.calculateProbability(any)).thenReturn(probability);
    when(damageCalculator.calculateDamage(any, any)).thenReturn(damageTaken);
    when(healthCalculator.calculateHealth(damageTaken: anyNamed("damageTaken"), fullHealth: anyNamed("fullHealth")))
        .thenReturn(returnedHealth);
  });

  test("FightDirector can be created and playOutRound", () {
    final underTest =
        FightDirector(player, diceRoller, damageCalculator, healthCalculator, probabilityCalculator, fullHealth);
    underTest.startWithNewEnemy(enemy);
    final returned = underTest.playOutTurn(player, probability, enemy, probability, TurnType.player);

    expect(returned.type, TurnType.player);
    expect(returned.attackAttribute, returnedTag);
    expect(returned.defendAttribute, returnedTag);
    expect(returned.damageDealt, 1);
    expect(returned.playerHealth.healthPercentage, returnedHealth.healthPercentage);
    expect(returned.playerHealth.displayableHealth, returnedHealth.displayableHealth);
    expect(returned.enemyHealth.healthPercentage, returnedHealth.healthPercentage);
    expect(returned.enemyHealth.displayableHealth, returnedHealth.displayableHealth);

    verify(probabilityCalculator.calculateProbability(any)).called(2);
    verify(damageCalculator.calculateDamage(any, any)).called(1);
    verify(healthCalculator.calculateHealth(damageTaken: anyNamed("damageTaken"), fullHealth: anyNamed("fullHealth")))
        .called(2);
  });

  test("FightDirector can start new fight with enemy", () {
    final underTest =
        FightDirector(player, diceRoller, damageCalculator, healthCalculator, probabilityCalculator, fullHealth);
    underTest.startWithNewEnemy(enemy);
    expect(underTest.round, 0);
  });

  test("FightDirector can be created and play player turn", () {
    final underTest =
        FightDirector(player, diceRoller, damageCalculator, healthCalculator, probabilityCalculator, fullHealth);
    underTest.startWithNewEnemy(enemy);
    expect(underTest.enemyDamageTaken, 0);

    final returned = underTest.playerTurn();

    expect(returned.type, TurnType.player);
    expect(underTest.enemyDamageTaken, damageTaken);
  });

  test("FightDirector can be created and play enemy turn", () {
    final underTest =
        FightDirector(player, diceRoller, damageCalculator, healthCalculator, probabilityCalculator, fullHealth);
    underTest.startWithNewEnemy(enemy);
    expect(underTest.playerDamageTaken, 0);

    final returned = underTest.enemyTurn();

    expect(returned.type, TurnType.enemy);
    expect(underTest.playerDamageTaken, damageTaken);
  });

  test("FightDirector should make even rounds players and odd enemy", () {
    final underTest =
        FightDirector(player, diceRoller, damageCalculator, healthCalculator, probabilityCalculator, fullHealth);
    underTest.startWithNewEnemy(enemy);
    expect(underTest.playerDamageTaken, 0);
    expect(underTest.enemyDamageTaken, 0);
    expect(underTest.round, 0);

    final shouldBePlayerTurn = underTest.makeTurn();

    expect(shouldBePlayerTurn.type, TurnType.player);
    expect(underTest.enemyDamageTaken, damageTaken);
    expect(underTest.round, 1);

    final shouldBeEnemyTurn = underTest.makeTurn();

    expect(shouldBeEnemyTurn.type, TurnType.enemy);
    expect(underTest.playerDamageTaken, damageTaken);
    expect(underTest.round, 2);

    final shouldBeSecondPlayerTurn = underTest.makeTurn();

    expect(shouldBeSecondPlayerTurn.type, TurnType.player);
    expect(underTest.enemyDamageTaken, damageTaken * 2);
    expect(underTest.round, 3);

    final shouldBeSecondEnemyTurn = underTest.makeTurn();

    expect(shouldBeSecondEnemyTurn.type, TurnType.enemy);
    expect(underTest.playerDamageTaken, damageTaken * 2);
    expect(underTest.round, 4);
  });

  test("FightDirector can choose from whom to take damage just by TurnType", () {
    final underTest =
        FightDirector(player, diceRoller, damageCalculator, healthCalculator, probabilityCalculator, fullHealth);
    underTest.giveDamageToCorrectFighter(TurnType.player, 10);
    expect(underTest.enemyDamageTaken, 10);
    underTest.giveDamageToCorrectFighter(TurnType.enemy, 30);
    expect(underTest.playerDamageTaken, 30);
  });
}
