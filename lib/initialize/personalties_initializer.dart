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
      Personalty("1", "Siłka", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 3, AttributeTag.rock),
      Personalty("1", "Cenzo", InGameLevel(level: 1, experience: 0, experienceStrategy: 100), 3, AttributeTag.knowledge),
    ];
    getIt.registerSingleton<PersonaltiesService>(PersonaltiesServiceImpl(personalties));
  }

}
