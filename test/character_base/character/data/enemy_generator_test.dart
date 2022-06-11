import 'dart:math';

import 'package:alpaka_clicker/base/randomizer/dice_roller.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_level_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_main_attribute_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/enemy_personalty_level_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/grade_probability_calculator.dart';
import 'package:alpaka_clicker/character_base/character/data/enemy_generator.dart';
import 'package:alpaka_clicker/character_base/character/models/difficulty_settings.dart';
import 'package:alpaka_clicker/util/pair.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testUtils/mocks.mocks.dart';

void main() {
  final gradeCalculator = MockGradeProbabilityCalculator();
  final levelProbabilityCalculator = MockEnemyLevelProbabilityCalculator();
  final attributeProbabilityCalculator = MockEnemyMainAttributeProbabilityCalculator();

  test("Random enemy generation test", () {
    final _diceRoller = DiceRoller(Random());
    final _gradeCalculator = GradeProbabilityCalculator();
    final _levelProbabilityCalculator = EnemyLevelProbabilityCalculator();
    final _attributeProbabilityCalculator = EnemyMainAttributeProbabilityCalculator();
    final _personaltyLevelProbabilityCalculator = EnemyPersonaltyLevelProbabilityCalculator();
    final underTest = EnemyGenerator(
        _gradeCalculator, _diceRoller, _levelProbabilityCalculator, _attributeProbabilityCalculator, _personaltyLevelProbabilityCalculator);

    for (int level = 10; level < 100; level += 25) {
      final range = Pair(level, level);
      final settings = DifficultySettings(range);
      final enemy = underTest.generateEnemy(settings);
      expect(enemy.level, level);
      expect(enemy.rockLevel + enemy.paperLevel + enemy.scissorsLevel + enemy.knowledgeLevel, level);
    }
  });

  test("Generating personalties level always returns ", () {
    final _diceRoller = DiceRoller(Random());
    final personaltyLevelCalculator = EnemyPersonaltyLevelProbabilityCalculator();
    final underTest =
        EnemyGenerator(gradeCalculator, _diceRoller, levelProbabilityCalculator, attributeProbabilityCalculator, personaltyLevelCalculator);
    for (int level = 10; level < 100; level += 25) {
      final levelsList = underTest.generateAttributesLevels(level);
      int levelsSum = 0;
      for (var element in levelsList) {
        levelsSum += element;
      }
      expect(levelsSum, level);
    }
  });
}
