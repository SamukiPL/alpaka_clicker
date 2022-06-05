import 'package:alpaka_clicker/base/randomizer/dice_roller.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/range_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/grade_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';

abstract class CharacterGenerator {
  final RangeProbabilityCalculator _rangeCalculator;
  final GradeProbabilityCalculator _gradeProbabilityCalculator;
  final DiceRoller _diceRoller;

  CharacterGenerator(this._rangeCalculator, this._gradeProbabilityCalculator, this._diceRoller);

  Attribute generateAttribute(Personalty personalty) {
    final attributeLevelProbability = _rangeCalculator.calculateRange(personalty.level);
    final level = _diceRoller.roll(attributeLevelProbability);
    final grade = generateGrade(personalty.attributeTag, personalty.level);

    return createCorrectAttribute(personalty.attributeTag, level, grade);
  }

  Grade generateGrade(AttributeTag attributeTag, int level) {
    final probability = _gradeProbabilityCalculator.calculateGrades(level);
    return _diceRoller.roll(probability);
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
