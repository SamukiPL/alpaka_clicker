import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:get_it/get_it.dart';

class CharacterInitializer extends Initializer {
  @override
  Future<void> call() async {
    final getIt = GetIt.instance;
    getIt.registerSingleton<Character>(Character(
        "Papuez",
        InGameLevel(level: 16, experience: 1, experienceStrategy: 1252),
        Rock(5, Grade.s),
        Paper(3, Grade.b),
        Scissors(7, Grade.a),
        Knowledge(1, Grade.f)));
  }
}
