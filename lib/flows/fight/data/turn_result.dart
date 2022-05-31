import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/turn_type.dart';

class TurnResult {
  final TurnType type;
  final String attackerName;
  final AttributeTag attackAttribute;
  final String defenderName;
  final AttributeTag defendAttribute;
  final int damageDealt;

  final HealthModel playerHealth;
  final HealthModel enemyHealth;

  TurnResult({
    required this.type,
    required this.attackerName,
    required this.attackAttribute,
    required this.defenderName,
    required this.defendAttribute,
    required this.damageDealt,
    required this.playerHealth,
    required this.enemyHealth,
  });
}
