import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/data/character_service_impl.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/util/exceptions/character_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testUtils/expect_throw.dart';

void main() {
  final character = Character(
    "Test",
    InGameLevel(level: 10, experience: 100, experienceStrategy: 1000),
    Rock(2, Grade.s),
    Paper(1, Grade.e),
    Scissors(3, Grade.a),
    Knowledge(7, Grade.c),
  );

  test("Character service takes character in constructor and returns copy of it", () {
    final underTest = CharacterServiceImpl(character);
    final returned = underTest.playerCharacter;
    expect(returned.name, character.name);
    expect(returned.experience, character.experience);
    expect(returned.rockLevel, character.rockLevel);
    expect(returned.rockGrade, character.rockGrade);
    expect(returned.paperLevel, character.paperLevel);
    expect(returned.paperGrade, character.paperGrade);
    expect(returned.scissorsLevel, character.scissorsLevel);
    expect(returned.scissorsGrade, character.scissorsGrade);
    expect(returned.knowledgeLevel, character.knowledgeLevel);
    expect(returned.knowledgeGrade, character.knowledgeGrade);
    returned.levelUpRock();
    final returnedAgain = underTest.playerCharacter;
    assert(returned.rockLevel > returnedAgain.rockLevel);
  });

  test("Character service takes experience that is added to character", () {
    const experience = 100;
    final underTest = CharacterServiceImpl(character);
    final returned = underTest.playerCharacter;
    expect(returned.experience, character.experience);
    underTest.addExperience(experience);
    final withNewExperience = underTest.playerCharacter;
    expect(withNewExperience.experience, returned.experience + experience);
  });

  test("Character service allows to level up rock", () {
    final underTest = CharacterServiceImpl(character);
    final returned = underTest.playerCharacter;
    expect(returned.rockLevel, character.rockLevel);
    underTest.levelUp(AttributeTag.rock);
    final returnedAgain = underTest.playerCharacter;
    expect(returnedAgain.rockLevel, returned.rockLevel + 1);
  });

  test("Character service allows to level up paper", () {
    final underTest = CharacterServiceImpl(character);
    final returned = underTest.playerCharacter;
    expect(returned.paperLevel, character.paperLevel);
    underTest.levelUp(AttributeTag.paper);
    final returnedAgain = underTest.playerCharacter;
    expect(returnedAgain.paperLevel, returned.paperLevel + 1);
  });

  test("Character service allows to level up scissors", () {
    final underTest = CharacterServiceImpl(character);
    final returned = underTest.playerCharacter;
    expect(returned.scissorsLevel, character.scissorsLevel);
    underTest.levelUp(AttributeTag.scissors);
    final returnedAgain = underTest.playerCharacter;
    expect(returnedAgain.scissorsLevel, returned.scissorsLevel + 1);
  });

  test("Character service allows to level up knowledge", () {
    final underTest = CharacterServiceImpl(character);
    final returned = underTest.playerCharacter;
    expect(returned.knowledgeLevel, character.knowledgeLevel);
    underTest.levelUp(AttributeTag.knowledge);
    final returnedAgain = underTest.playerCharacter;
    expect(returnedAgain.knowledgeLevel, returned.knowledgeLevel + 1);
  });

  test("Character service will throw when trying to levelUp attribute without any points to redeem", () {
    final underTest = CharacterServiceImpl(character);
    expectThrow(() => underTest.levelUp(AttributeTag.rock), NoMorePointToLevelUpAttributeException);
  });

  // test("Character service returns new generated player character", () {
  //   final underTest = CharacterServiceImpl(character);
  //   underTest.generateNewPlayerCharacter();
  // });
  //
  // test("Character service returns new generated enemy character", () {
  //   final underTest = CharacterServiceImpl(character);
  //   underTest.generateNewPlayerCharacter();
  // });
}
