import 'package:alpaka_clicker/character_base/attributes.dart';
import 'package:injectable/injectable.dart';

@injectable
class DamageCalculator {
  int damagePerLevel = 10;
  int blockPerLevel = 5;

  int calculateDamage(Attribute attackerAtt, Attribute defenderAtt) {
    final strengthFactor = attributeStrengthFactor(attackerAtt, defenderAtt.tag);
    final attackerDamage = (attackerAtt.level * damagePerLevel * strengthFactor).ceil();
    final defenderBlock = (defenderAtt.level * blockPerLevel).ceil();
    return attackerDamage - defenderBlock;
  }

  double attributeStrengthFactor(Attribute attackerAtt, AttributeTag defenderTag) {
    if (attackerAtt.tag == defenderTag) {
      return 1;
    } else if (attackerAtt.strengths.any((element) => element == defenderTag)) {
      return 1.25;
    } else {
      return 0.75;
    }
  }
}
