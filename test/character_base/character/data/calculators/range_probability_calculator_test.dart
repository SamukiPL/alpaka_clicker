import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/range_probability_calculator.dart';
import 'package:alpaka_clicker/util/pair.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final startingPair = Pair(1, 3);

  test("Attribute probability calculator returns starting pair for level 1", () {
    final underTest = RangeProbabilityCalculator(startingPair);
    Probability<int> probability = underTest.calculateRange(1);
    expect(probability.attributesProp[startingPair.first - 1]! < probability.attributesProp[startingPair.last - 1]!, true);
    expect(probability.attributesProp[startingPair.first - 1], startingPair.first);
    expect(probability.attributesProp[startingPair.last - 1], startingPair.last);
  });

  test("Attribute probability calculator returns starting pair plus 1 for level 2", () {
    final underTest = RangeProbabilityCalculator(startingPair);
    Probability<int> probability = underTest.calculateRange(2);
    expect(probability.attributesProp[startingPair.first - 1]! < probability.attributesProp[startingPair.last - 1]!, true);
    expect(probability.attributesProp[startingPair.first - 1], startingPair.first + 1);
    expect(probability.attributesProp[startingPair.last - 1], startingPair.last + 1);
  });

  test("Attribute probability calculator returns starting pair plus level - 1", () {
    final underTest = RangeProbabilityCalculator(startingPair);
    Probability<int> probability = underTest.calculateRange(36);
    expect(probability.attributesProp[startingPair.first - 1]! < probability.attributesProp[startingPair.last - 1]!, true);
    expect(probability.attributesProp[startingPair.first - 1], startingPair.first + 35);
    expect(probability.attributesProp[startingPair.last - 1], startingPair.last + 35);
  });
}
