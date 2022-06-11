import 'package:alpaka_clicker/base/randomizer/dice_roller.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/grade_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';

abstract class CharacterGenerator {
  final GradeProbabilityCalculator gradeProbabilityCalculator;
  final DiceRoller diceRoller;

  CharacterGenerator(this.gradeProbabilityCalculator, this.diceRoller);

  Grade generateGrade(AttributeTag attributeTag, int level) {
    final probability = gradeProbabilityCalculator.calculateGrades(level);
    return diceRoller.roll(probability);
  }

  Attribute createCorrectAttribute(AttributeTag attributeTag, int level, Grade grade) {
    switch (attributeTag) {
      case AttributeTag.rock:
        return Rock(level, grade);
      case AttributeTag.paper:
        return Paper(level, grade);
      case AttributeTag.scissors:
        return Scissors(level, grade);
      case AttributeTag.knowledge:
        return Knowledge(level, grade);
    }
  }
}
