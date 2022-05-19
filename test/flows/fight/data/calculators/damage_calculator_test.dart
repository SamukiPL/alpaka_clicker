import 'package:alpaka_clicker/character_base/attributes.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/damage_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("DamageCalculator returns damage factor for same attribute", () {
    final rock = Rock(1, Grade.a);
    final underTest = DamageCalculator();
    final factor = underTest.attributeStrengthFactor(rock, rock.tag);
    expect(factor, 1);
  });

  test("DamageCalculator returns damage factor for strengths", () {
    final rock = Rock(1, Grade.a);
    final underTest = DamageCalculator();
    final factor = underTest.attributeStrengthFactor(rock, rock.strengths.first);
    expect(factor, 1.25);
  });

  test("DamageCalculator returns damage factor for tag not in the strength", () {
    final rock = Rock(1, Grade.a);
    final underTest = DamageCalculator();
    final factor = underTest.attributeStrengthFactor(rock, AttributeTag.knowledge);
    expect(factor, 0.75);
  });
  
  test("DamageCalculator accepts attackers and defended attribute level and tag, calculates damage", () {
    final attackerAtt = Rock(1, Grade.a);
    final defenderAtt = Rock(1, Grade.a);
    final underTest = DamageCalculator();
    int damage = underTest.calculateDamage(attackerAtt, defenderAtt);
    expect(damage, 5);
  });

  test("DamageCalculator calculates for attribute and strength", () {
    final attackerAtt = Rock(1, Grade.a);
    final defenderAtt = Scissors(1, Grade.a);
    final underTest = DamageCalculator();
    int damage = underTest.calculateDamage(attackerAtt, defenderAtt);
    expect(damage, 8);
  });

  test("DamageCalculator calculates for attribute and its weakness", () {
    final attackerAtt = Rock(1, Grade.a);
    final defenderAtt = Paper(1, Grade.a);
    final underTest = DamageCalculator();
    int damage = underTest.calculateDamage(attackerAtt, defenderAtt);
    expect(damage, 3);
  });

  test("DamageCalculator calculates damage that will give normally negative numbers but returns 0", () {
    final attackerAtt = Rock(1, Grade.a);
    final defenderAtt = Paper(100, Grade.a);
    final underTest = DamageCalculator();
    int damage = underTest.calculateDamage(attackerAtt, defenderAtt);
    expect(damage, 0);
  });
}
