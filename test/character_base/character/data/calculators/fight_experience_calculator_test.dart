import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/data/calculators/fight_experience_calculator.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final startLevel = InGameLevel(level: 10, experience: 0, experienceStrategy: 10);
  final player = Character("", startLevel, Rock(1, Grade.a), Paper(1, Grade.a), Scissors(1, Grade.a), Knowledge(1, Grade.a));

  test("Simple test for experience calculation when level is lower", () {
    final enemyLevel = InGameLevel(level: startLevel.level - 4, experience: 0, experienceStrategy: 10);
    final enemy = Character("", enemyLevel, Rock(1, Grade.a), Paper(1, Grade.a), Scissors(1, Grade.a), Knowledge(1, Grade.a));
    final underTest = FightExperienceCalculator();

    final experience = underTest.calculateExperience(player, enemy);
    expect(experience, 10);
  });

  test("Simple test for experience calculation when level is higher", () {
    final enemyLevel = InGameLevel(level: startLevel.level + 5, experience: 0, experienceStrategy: 10);
    final enemy = Character("", enemyLevel, Rock(1, Grade.a), Paper(1, Grade.a), Scissors(1, Grade.a), Knowledge(1, Grade.a));
    final underTest = FightExperienceCalculator();

    final experience = underTest.calculateExperience(player, enemy);
    expect(experience, 100);
  });

  test("Simple test for experience calculation when level too low", () {
    final enemyLevel = InGameLevel(level: startLevel.level - 5, experience: 0, experienceStrategy: 10);
    final enemy = Character("", enemyLevel, Rock(1, Grade.a), Paper(1, Grade.a), Scissors(1, Grade.a), Knowledge(1, Grade.a));
    final underTest = FightExperienceCalculator();

    final experience = underTest.calculateExperience(player, enemy);
    expect(experience, 1);
  });
}
