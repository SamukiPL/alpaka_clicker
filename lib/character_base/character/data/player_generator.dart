import 'package:alpaka_clicker/base/randomizer/dice_roller.dart';
import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/grade_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/attribute_level_range_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/character_generator.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlayerGenerator extends CharacterGenerator {
  final AttributeLevelRangeProbabilityCalculator rangeCalculator;

  PlayerGenerator(this.rangeCalculator, GradeProbabilityCalculator gradeProbabilityCalculator, DiceRoller diceRoller)
      : super(gradeProbabilityCalculator, diceRoller);

  Character generatePlayer(String name, List<Personalty> personalties) {
    Rock rock = generateAttribute(personalties.firstWhere((element) => element.attributeTag == AttributeTag.rock)) as Rock;
    Paper paper = generateAttribute(personalties.firstWhere((element) => element.attributeTag == AttributeTag.paper)) as Paper;
    Scissors scissors = generateAttribute(personalties.firstWhere((element) => element.attributeTag == AttributeTag.scissors)) as Scissors;
    Knowledge knowledge = generateAttribute(personalties.firstWhere((element) => element.attributeTag == AttributeTag.knowledge)) as Knowledge;

    final level = rock.level + paper.level + scissors.level + knowledge.level - 3;
    final characterLevel = InGameLevel(level: level, experience: 0, experienceStrategy: 1000);

    return Character(name, characterLevel, rock, paper, scissors, knowledge);
  }

  Attribute generateAttribute(Personalty personalty) {
    final attributeLevelProbability = rangeCalculator.calculateRange(personalty.level);
    final attributeLevel = diceRoller.roll(attributeLevelProbability);
    final grade = generateGrade(personalty.attributeTag, attributeLevel);

    return createCorrectAttribute(personalty.attributeTag, attributeLevel, grade);
  }
}
