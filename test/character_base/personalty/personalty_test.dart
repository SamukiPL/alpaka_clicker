import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../testUtils/mocked_models.dart';

void main() {
  test("Personalty can be created with attribute tag", () {
    final level = InGameLevel(level: 1, experience: 0, experienceStrategy: 1000);
    final underTest = Personalty("key", "test", level, 3, AttributeTag.rock);
    expect(underTest.level, level.level);
    expect(underTest.experience, level.experience);
    expect(underTest.requiredExperience, level.experienceStrategy);
  });

  test("Personalty can return price", () {
    const startingPower = 3;
    final level = InGameLevel(level: 0, experience: 0, experienceStrategy: 1000);
    final underTest = Personalty("key", "test", level, startingPower, AttributeTag.rock);
    expect(underTest.price, currency(1, startingPower));
  });

  test("Personalty can be level up externally", () {
    const startingLevel = 0;
    final level = InGameLevel(level: startingLevel, experience: 0, experienceStrategy: 1000);
    final underTest = Personalty("key", "test", level, 3, AttributeTag.rock);
    underTest.levelUpExternally();
    expect(underTest.level, startingLevel + 1);
  });

  test("Personalty will increase price every time you buy by power + 1", () {
    const startingPower = 3;
    const startingLevel = 3;
    final level = InGameLevel(level: startingLevel, experience: 0, experienceStrategy: 1000);
    final underTest = Personalty("key", "test", level, startingPower, AttributeTag.rock);
    expect(underTest.price, currency(1, startingPower + startingLevel));
  });

  test("Personalty can get new experience points and add it to its experience", () {
    const startingExperience = 0;
    const newExperience = 100;
    final level = InGameLevel(level: 0, experience: startingExperience, experienceStrategy: 1000);
    final underTest = Personalty("key", "test", level, 0, AttributeTag.rock);
    underTest.addExperience(newExperience);
    expect(underTest.experience, startingExperience + newExperience);
  });

  test("Personalty will level up with enough experience", () {
    const startingLevel = 0;
    const nextLevel = 100;
    final level = InGameLevel(level: 0, experience: 0, experienceStrategy: nextLevel);
    final underTest = Personalty("key", "test", level, 0, AttributeTag.rock);
    underTest.addExperience(nextLevel);
    expect(underTest.level, startingLevel + 1);
  });
}
