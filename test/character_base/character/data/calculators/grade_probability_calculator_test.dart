import 'package:alpaka_clicker/character_base/character/data/calculators/grade_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Grade probability calculator calculates probability", () {
    final underTest = GradeProbabilityCalculator();
    final probability = underTest.calculateGrades(0);
    expect(probability.probSum, probability.attributesProp.keys.last);
    expect(probability.attributesProp.length, Grade.values.length);
  });

  test("Grade probability calculator calculates probability for very big level and returns only Grade.s", () {
    final underTest = GradeProbabilityCalculator();
    final probability = underTest.calculateGrades(10000);
    expect(probability.probSum, 1);
    expect(probability.attributesProp.length, 1);
  });
}
