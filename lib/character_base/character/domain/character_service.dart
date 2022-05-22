import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';

abstract class CharacterService {
  Character getPlayerCharacter();
  Future<void> addExperience(int experience);
  Future<void> levelUp(AttributeTag tag);
  Character generateNewPlayerCharacter();
  Character generateEnemyCharacter();
}
