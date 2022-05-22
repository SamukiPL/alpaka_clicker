import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/domain/character_service.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CharacterService)
class CharacterServiceImpl implements CharacterService {
  @override
  Future<void> addExperience(int experience) {
    // TODO: implement addExperience
    throw UnimplementedError();
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

  @override
  Character getPlayerCharacter() {
    // TODO: implement getPlayerCharacter
    throw UnimplementedError();
  }

  @override
  Future<void> levelUp(AttributeTag tag) {
    // TODO: implement levelUp
    throw UnimplementedError();
  }

}
