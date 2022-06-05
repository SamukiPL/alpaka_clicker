import 'package:alpaka_clicker/base/randomizer/probability.dart';
import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/character_base/character/data/player_generator.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../testUtils/dummy_mocks.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  final personalties = <Personalty>[
    Personalty("rockKey", "rock", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 6, AttributeTag.rock),
    Personalty("paperKey", "paper", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 6, AttributeTag.paper),
    Personalty("scissorsKey", "scissors", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 6, AttributeTag.scissors),
    Personalty("knowledgeKey", "knowledge", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 6, AttributeTag.knowledge),
  ];

  final diceRoller = MockDiceRoller(dummyReturn: <T>(prob) => prob.attributesProp.values.first);
  final rangeCalculator = MockAttributeRangeCalculator();
  final gradeCalculator = MockGradeProbabilityCalculator();

  const returnedLevel = 1;
  const returnedGrade = Grade.a;

  setUpAll(() {
    when(rangeCalculator.calculateRange(any)).thenReturn(Probability(1, {1: returnedLevel}));
    when(gradeCalculator.calculateGrades(any)).thenReturn(Probability(1, {1: Grade.a}));
  });

  test("Character generator accepts personalties list and returns character", () {
    const name = "name";

    final underTest = PlayerGenerator(rangeCalculator, gradeCalculator, diceRoller);
    Character character = underTest.generatePlayer(name, personalties);
    expect(character.name, name);
    expect(character.level, 1);
    expect(character.experience, 0);
    expect(character.experienceStrategy, 1000);

    expect(character.rockLevel, returnedLevel);
    expect(character.rockGrade, returnedGrade);

    expect(character.paperLevel, returnedLevel);
    expect(character.paperGrade, returnedGrade);

    expect(character.scissorsLevel, returnedLevel);
    expect(character.scissorsGrade, returnedGrade);

    expect(character.knowledgeLevel, returnedLevel);
    expect(character.knowledgeGrade, returnedGrade);

    expect(character.pointsToDistribute, 0);
  });

  test("Character generator returns newly generated attribute", () {
    final personalty = Personalty("rockKey", "rock", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 6, AttributeTag.rock);

    final underTest = PlayerGenerator(rangeCalculator, gradeCalculator, diceRoller);
    Attribute rock = underTest.generateAttribute(personalty);
    expect(rock is Rock, true);
    expect(rock.tag, personalty.attributeTag);
    expect(rock.level, returnedLevel);
    expect(rock.grade, returnedGrade);
  });

  test("Character generator randomize grade", () {
    final personalty = Personalty("rockKey", "rock", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 6, AttributeTag.rock);

    final underTest = PlayerGenerator(rangeCalculator, gradeCalculator, diceRoller);
    Grade grade = underTest.generateGrade(personalty.attributeTag, personalty.level);
    expect(grade, returnedGrade);
  });

  test("Character generator chooses correct attribute implementation after taking rock tag", () {
    const level = 2;
    const grade = Grade.e;
    final underTest = PlayerGenerator(rangeCalculator, gradeCalculator, diceRoller);
    final rock = underTest.createCorrectAttribute(AttributeTag.rock, level, grade);
    expect(rock.runtimeType, Rock);
    expect(rock.level, level);
    expect(rock.grade, grade);
  });

  test("Character generator chooses correct attribute implementation after taking paper tag", () {
    const level = 2;
    const grade = Grade.e;
    final underTest = PlayerGenerator(rangeCalculator, gradeCalculator, diceRoller);
    final paper = underTest.createCorrectAttribute(AttributeTag.paper, level, grade);
    expect(paper.runtimeType, Paper);
    expect(paper.level, level);
    expect(paper.grade, grade);
  });

  test("Character generator chooses correct attribute implementation after taking scissors tag", () {
    const level = 2;
    const grade = Grade.e;
    final underTest = PlayerGenerator(rangeCalculator, gradeCalculator, diceRoller);
    final scissors = underTest.createCorrectAttribute(AttributeTag.scissors, level, grade);
    expect(scissors.runtimeType, Scissors);
    expect(scissors.level, level);
    expect(scissors.grade, grade);
  });

  test("Character generator chooses correct attribute implementation after taking knowledge tag", () {
    const level = 2;
    const grade = Grade.e;
    final underTest = PlayerGenerator(rangeCalculator, gradeCalculator, diceRoller);
    final knowledge = underTest.createCorrectAttribute(AttributeTag.knowledge, level, grade);
    expect(knowledge.runtimeType, Knowledge);
    expect(knowledge.level, level);
    expect(knowledge.grade, grade);
  });
}
