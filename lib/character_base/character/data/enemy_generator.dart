import 'package:alpaka_clicker/base/randomizer/dice_roller.dart';
import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_level_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_main_attribute_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_personalty_level_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/grade_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/character_generator.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/difficulty_settings.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/util/pair.dart';
import 'package:injectable/injectable.dart';

@injectable
class EnemyGenerator extends CharacterGenerator {
  final EnemyLevelProbabilityCalculator levelProbabilityCalculator;
  final EnemyMainAttributeProbabilityCalculator attributeProbabilityCalculator;
  final EnemyPersonaltyLevelProbabilityCalculator personaltyLevelProbabilityCalculator;

  EnemyGenerator(GradeProbabilityCalculator gradeProbabilityCalculator, DiceRoller diceRoller, this.levelProbabilityCalculator,
      this.attributeProbabilityCalculator, this.personaltyLevelProbabilityCalculator)
      : super(gradeProbabilityCalculator, diceRoller);

  Character generateEnemy(DifficultySettings settings) {
    final enemyLevel = generateCharacterLevel(settings.levelRange);
    final generationQueue = getAttributesGenerationQueue();
    final personaltiesLevels = generateAttributesLevels(enemyLevel);

    final attributesPersonaltiesMap = generationQueue.asMap().map((key, attributeTag) => MapEntry(attributeTag, personaltiesLevels[key]));

    final enemyInGameLevel = InGameLevel(level: enemyLevel, experience: 1, experienceStrategy: 100);
    final rock = generateAttribute(AttributeTag.rock, attributesPersonaltiesMap[AttributeTag.rock]!) as Rock;
    final paper = generateAttribute(AttributeTag.paper, attributesPersonaltiesMap[AttributeTag.paper]!) as Paper;
    final scissors = generateAttribute(AttributeTag.scissors, attributesPersonaltiesMap[AttributeTag.scissors]!) as Scissors;
    final knowledge = generateAttribute(AttributeTag.knowledge, attributesPersonaltiesMap[AttributeTag.knowledge]!) as Knowledge;

    return Character("ENEMY TODO", enemyInGameLevel, rock, paper, scissors, knowledge);
  }

  int generateCharacterLevel(Range range) {
    final probability = levelProbabilityCalculator.calculateRange(range);
    return diceRoller.roll(probability);
  }

  List<AttributeTag> getAttributesGenerationQueue() {
    final mainAttribute = generateMainAttribute();
    switch (mainAttribute) {
      case AttributeTag.rock:
        return [AttributeTag.rock, AttributeTag.paper, AttributeTag.scissors, AttributeTag.knowledge];
      case AttributeTag.paper:
        return [AttributeTag.paper, AttributeTag.scissors, AttributeTag.rock, AttributeTag.knowledge];
      case AttributeTag.scissors:
        return [AttributeTag.scissors, AttributeTag.rock, AttributeTag.paper, AttributeTag.knowledge];
      case AttributeTag.knowledge:
        final randomAttributeQueue = [AttributeTag.rock, AttributeTag.paper, AttributeTag.scissors]..shuffle();
        return [AttributeTag.knowledge] + randomAttributeQueue;
    }
  }

  AttributeTag generateMainAttribute() {
    final probability = attributeProbabilityCalculator.calculateMainAttribute();
    return diceRoller.roll(probability);
  }

  List<int> generateAttributesLevels(int enemyLevel) {
    int rest = enemyLevel;
    return List.generate(4, (index) {
      if (index == 3) {
        return rest;
      }
      final probability = personaltyLevelProbabilityCalculator.calculatePersonaltyLevel(rest);
      final level = diceRoller.roll(probability);
      rest -= level;
      return level;
    });
  }

  Attribute generateAttribute(AttributeTag attributeTag, int level) {
    final grade = generateGrade(attributeTag, level);
    return createCorrectAttribute(attributeTag, level, grade);
  }
}
