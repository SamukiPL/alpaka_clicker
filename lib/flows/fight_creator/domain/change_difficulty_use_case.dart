import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_type.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/fight_creator_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeDifficultyUseCase {
  final FightCreatorRepository _repository;

  ChangeDifficultyUseCase(this._repository);

  Future<void> call(DifficultyType type) => _repository.changeDifficulty(type);
}
