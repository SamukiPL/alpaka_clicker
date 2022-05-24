import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final level = InGameLevel(level: 1, experience: 0, experienceStrategy: 100);
  const startLevel = 1;
  final rock = Rock(startLevel, Grade.s);
  final paper = Paper(startLevel, Grade.a);
  final scissors = Scissors(startLevel, Grade.b);
  final knowledge = Knowledge(startLevel, Grade.c);

  test("Character can be created with paper, rock, scissors and knowledge with name and level with experience", () {
    Character("name", level, rock, paper, scissors, knowledge);
  });

  test("Character can take experience and return current experience ", () {
    const exp = 21;
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.experience, level.experience);
    character.giveExperience(exp);
    expect(character.experience, level.experience + exp);
  });

  test("Character can take experience and bump up its level", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.level, level.level);
    character.giveExperience(level.experienceStrategy);
    expect(character.level, level.level + 1);
  });

  test("Character can upgrade levelUp rock attribute", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.rockLevel, startLevel);
    character.levelUpRock();
    expect(character.rockLevel, startLevel + 1);
  });

  test("Character can upgrade levelUp paper attribute", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.paperLevel, startLevel);
    character.levelUpPaper();
    expect(character.paperLevel, startLevel + 1);
  });

  test("Character can upgrade levelUp scissors attribute", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.scissorsLevel, startLevel);
    character.levelUpScissors();
    expect(character.scissorsLevel, startLevel + 1);
  });

  test("Character can upgrade levelUp knowledge attribute", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.knowledgeLevel, startLevel);
    character.levelUpKnowledge();
    expect(character.knowledgeLevel, startLevel + 1);
  });

  test("Character returns rocks grade", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.rockGrade, rock.grade);
  });

  test("Character returns paper grade", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.paperGrade, paper.grade);
  });

  test("Character returns scissors grade", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.scissorsGrade, scissors.grade);
  });

  test("Character returns knowledge grade", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.knowledgeGrade, knowledge.grade);
  });

  test("Character returns its Rock attribute after passing AttributeTag.rock", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.getAttributeByTag(AttributeTag.rock).runtimeType, Rock);
  });

  test("Character returns its Paper attribute after passing AttributeTag.paper", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.getAttributeByTag(AttributeTag.paper).runtimeType, Paper);
  });

  test("Character returns its Scissors attribute after passing AttributeTag.scissors", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.getAttributeByTag(AttributeTag.scissors).runtimeType, Scissors);
  });

  test("Character returns its Knowledge attribute after passing AttributeTag.knowledge", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.getAttributeByTag(AttributeTag.knowledge).runtimeType, Knowledge);
  });

  test("Character returns how much points you can distribute to attributes", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    expect(character.pointsToDistribute, 0);
    character.giveExperience(level.experienceStrategy);
    expect(character.pointsToDistribute, 1);
    character.levelUpKnowledge();
    expect(character.pointsToDistribute, 0);
  });

  test("Character can be copied", () {
    final character = Character("name", level, rock, paper, scissors, knowledge);
    Character copy = character.copy();
    expect(copy.name, character.name);
    expect(copy.experience, character.experience);
    expect(copy.rockLevel, character.rockLevel);
    expect(copy.rockGrade, character.rockGrade);
    expect(copy.paperLevel, character.paperLevel);
    expect(copy.paperGrade, character.paperGrade);
    expect(copy.scissorsLevel, character.scissorsLevel);
    expect(copy.scissorsGrade, character.scissorsGrade);
    expect(copy.knowledgeLevel, character.knowledgeLevel);
    expect(copy.knowledgeGrade, character.knowledgeGrade);
    character.levelUpRock();
    expect(character.rockLevel, copy.rockLevel + 1);
  });
}
