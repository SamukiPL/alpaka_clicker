import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("CharacterLevel can be created with level, experience and strategy", () {
    InGameLevel(level: 1, experience: 1, experienceStrategy: 1);
  });

  test("Add int to CharacterLevel with operator adds int to experience", () {
    InGameLevel level = InGameLevel(level: 1, experience: 1, experienceStrategy: 100);
    level += 1;
    expect(level.experience, 2);
  });

  test("Adding int that will exceed experience strategy will result with higher level", () {
    InGameLevel level = InGameLevel(level: 1, experience: 1, experienceStrategy: 100);
    level += 100;
    expect(level.level, 2);
  });

  test("Adding int that will exceed strategy 9 times will result with higher level", () {
    InGameLevel level = InGameLevel(level: 1, experience: 1, experienceStrategy: 100);
    level += 989;
    expect(level.experience, 90);
    expect(level.level, 10);
  });
}
