import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/domain/character_service.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/util/exceptions/character_exceptions.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CharacterService)
class CharacterServiceImpl implements CharacterService {
  final Character _character;

  CharacterServiceImpl(this._character);

  @override
  Character get playerCharacter => _character.copy();

  @override
  void addExperience(int experience) {
    _character.giveExperience(experience);
  }

  @override
  void levelUp(AttributeTag tag) {
    if (_character.pointsToDistribute <= 0) throw NoMorePointToLevelUpAttributeException();

    switch(tag) {
      case AttributeTag.rock:
        return _character.levelUpRock();
      case AttributeTag.paper:
        return _character.levelUpPaper();
      case AttributeTag.scissors:
        return _character.levelUpScissors();
      case AttributeTag.knowledge:
        return _character.levelUpKnowledge();
    }
  }

  @override
  Character generateEnemyCharacter() {
    // TODO: implement generateEnemyCharacter
    throw UnimplementedError();
  }

  @override
  Character generateNewPlayerCharacter() {
    // TODO: implement generateNewPlayerCharacter
    throw UnimplementedError();
  }

}
