import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';

class Character {
  final String name;
  InGameLevel _level;
  Rock _rock;
  Paper _paper;
  Scissors _scissors;
  Knowledge _knowledge;

  Character(this.name, this._level, this._rock, this._paper, this._scissors, this._knowledge);

  int get experience => _level.experience;

  int get rockLevel => _rock.level;
  Grade get rockGrade => _rock.grade;

  int get paperLevel => _paper.level;
  Grade get paperGrade => _paper.grade;

  int get scissorsLevel => _scissors.level;
  Grade get scissorsGrade => _scissors.grade;

  int get knowledgeLevel => _knowledge.level;
  Grade get knowledgeGrade => _knowledge.grade;

  Attribute getAttributeByTag(AttributeTag tag) {
    switch(tag) {
      case AttributeTag.rock:
        return _rock;
      case AttributeTag.paper:
        return _paper;
      case AttributeTag.scissors:
        return _scissors;
      case AttributeTag.knowledge:
        return _knowledge;
    }
  }

  void giveExperience(int experience) {
    _level += experience;
  }

  void levelUpRock() => _rock += 1;

  void levelUpPaper() => _paper += 1;

  void levelUpScissors() => _scissors += 1;

  void levelUpKnowledge() => _knowledge += 1;
}
