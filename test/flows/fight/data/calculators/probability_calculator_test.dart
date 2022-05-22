import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/probability.dart';
import 'package:alpaka_clicker/flows/fight/data/calculators/probability_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("ProbabilityCalculator have defined final value for base probability", () {
    final underTest = ProbabilityCalculator();
    expect(underTest.baseProbability, 25);
  });

  test("ProbabilityCalculator have inside method for grade probability factor, test for Grade.s that should be 30", () {
    final underTest = ProbabilityCalculator();
    expect(underTest.getGradeFactor(Grade.s), 30);
  });

  test("ProbabilityCalculator have inside method for grade probability factor, test for Grade.a that should be 20", () {
    final underTest = ProbabilityCalculator();
    expect(underTest.getGradeFactor(Grade.a), 20);
  });

  test("ProbabilityCalculator have inside method for grade probability factor, test for Grade.b that should be 15", () {
    final underTest = ProbabilityCalculator();
    expect(underTest.getGradeFactor(Grade.b), 15);
  });

  test("ProbabilityCalculator have inside method for grade probability factor, test for Grade.c that should be 5", () {
    final underTest = ProbabilityCalculator();
    expect(underTest.getGradeFactor(Grade.c), 5);
  });

  test("ProbabilityCalculator have inside method for grade probability factor, test for Grade.d that should be -5", () {
    final underTest = ProbabilityCalculator();
    expect(underTest.getGradeFactor(Grade.d), -5);
  });

  test("ProbabilityCalculator have inside method for grade probability factor, test for Grade.e that should be -15",
      () {
    final underTest = ProbabilityCalculator();
    expect(underTest.getGradeFactor(Grade.e), -15);
  });

  test("ProbabilityCalculator have inside method for grade probability factor, test for Grade.f that should be -24",
      () {
    final underTest = ProbabilityCalculator();
    expect(underTest.getGradeFactor(Grade.f), -24);
  });

  test("ProbabilityCalculator accepts character to calculate Probability for grades s, a, b and c", () {
    final rock = Rock(1, Grade.s); //25 + 30 = rock
    final paper = Paper(1, Grade.a); //25 + 20 + rock = paper
    final scissors = Scissors(1, Grade.b); //25 + 15 + paper = scissors
    final knowledge = Knowledge(1, Grade.c); //25 + 5 + scissors
    final character = Character(
        "Test", InGameLevel(level: 1, experience: 1, experienceStrategy: 100), rock, paper, scissors, knowledge);
    final underTest = ProbabilityCalculator();
    Probability returned = underTest.calculateProbability(character);
    // ignore: unnecessary_type_check
    assert(returned is Probability);
    expect(returned.probSum, (25 * 4) + 30 + 20 + 15 + 5);
    final rockProb = returned.attributesProp.entries.firstWhere((element) => element.value == AttributeTag.rock).key;
    expect(rockProb, 25 + 30);
    final paperProb = returned.attributesProp.entries.firstWhere((element) => element.value == AttributeTag.paper).key;
    expect(paperProb, 25 + 20 + rockProb);
    final scissorsProb =
        returned.attributesProp.entries.firstWhere((element) => element.value == AttributeTag.scissors).key;
    expect(scissorsProb, 25 + 15 + paperProb);
    final knowledgeProb =
        returned.attributesProp.entries.firstWhere((element) => element.value == AttributeTag.knowledge).key;
    expect(knowledgeProb, 25 + 5 + scissorsProb);
  });

  test("ProbabilityCalculator accepts character to calculate Probability for grades s, d, e and f", () {
    final rock = Rock(1, Grade.s); //25 + 30 = rock
    final paper = Paper(1, Grade.d); //25 - 5 + rock
    final scissors = Scissors(1, Grade.e); //25 - 15
    final knowledge = Knowledge(1, Grade.f); //25 - 24
    final character = Character(
        "Test", InGameLevel(level: 1, experience: 1, experienceStrategy: 100), rock, paper, scissors, knowledge);
    final underTest = ProbabilityCalculator();
    Probability returned = underTest.calculateProbability(character);
    expect(returned.probSum, (25 * 4) + 30 - 5 - 15 - 24);
    final rockProb = returned.attributesProp.entries.firstWhere((element) => element.value == AttributeTag.rock).key;
    expect(rockProb, 25 + 30);
    final paperProb = returned.attributesProp.entries.firstWhere((element) => element.value == AttributeTag.paper).key;
    expect(paperProb, 25 - 5 + rockProb);
    final scissorsProb =
        returned.attributesProp.entries.firstWhere((element) => element.value == AttributeTag.scissors).key;
    expect(scissorsProb, 25 - 15 + paperProb);
    final knowledgeProb =
        returned.attributesProp.entries.firstWhere((element) => element.value == AttributeTag.knowledge).key;
    expect(knowledgeProb, 25 - 24 + scissorsProb);
  });
}
