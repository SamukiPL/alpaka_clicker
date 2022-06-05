import 'package:alpaka_clicker/base/randomizer/dice_roller.dart';
import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/range_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/grade_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/character_generator.dart';
import 'package:alpaka_clicker/character_base/character/models/difficulty_settings.dart';

class EnemyGenerator extends CharacterGenerator {
  EnemyGenerator(RangeProbabilityCalculator rangeCalculator, GradeProbabilityCalculator gradeProbabilityCalculator, DiceRoller diceRoller)
      : super(rangeCalculator, gradeProbabilityCalculator, diceRoller);

  Character generateEnemy(DifficultySettings settings) {
    throw UnimplementedError();
  }
}
