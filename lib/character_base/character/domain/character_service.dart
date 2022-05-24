import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/models/attributes.dart';

abstract class CharacterService {
  Character get playerCharacter;
  void addExperience(int experience);
  void levelUp(AttributeTag tag);
  Character generateNewPlayerCharacter();
  Character generateEnemyCharacter();
}
