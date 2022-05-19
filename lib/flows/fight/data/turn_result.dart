import 'package:alpaka_clicker/character_base/attributes.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/health_model.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/turn_type.dart';

class TurnResult {
  final TurnType type;
  final AttributeTag attackAttribute;
  final AttributeTag defendAttribute;
  final int damageDealt;

  final HealthModel playerHealth;
  final HealthModel enemyHealth;

  TurnResult({
    required this.type,
    required this.attackAttribute,
    required this.defendAttribute,
    required this.damageDealt,
    required this.playerHealth,
    required this.enemyHealth,
  });
}
