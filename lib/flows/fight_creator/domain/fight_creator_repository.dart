import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_type.dart';

abstract class FightCreatorRepository {
  Stream<DifficultyModel> observeDifficulty();

  Future<void> changeDifficulty(DifficultyType type);
}
