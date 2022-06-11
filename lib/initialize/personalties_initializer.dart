import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/character_base/personalty/data/personalties_service_impl.dart';
import 'package:alpaka_clicker/character_base/personalty/domain/personalties_service.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';
import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:get_it/get_it.dart';

class PersonaltiesInitializer extends Initializer {
  @override
  Future<void> call() async {
    final getIt = GetIt.instance;
    //TODO
    final personalties = <Personalty>[
      Personalty("silkaKey", "Siłka", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 6, AttributeTag.rock),
      Personalty("cenzoKey", "Cenzo", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 6, AttributeTag.knowledge),
    ];
    getIt.registerSingleton<PersonaltiesService>(PersonaltiesServiceImpl(personalties));
  }
}
