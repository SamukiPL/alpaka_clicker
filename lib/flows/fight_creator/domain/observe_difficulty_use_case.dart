import 'package:alpaka_clicker/flows/fight_creator/domain/difficulty_model.dart';
import 'package:alpaka_clicker/flows/fight_creator/domain/fight_creator_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ObserveDifficultyUseCase {
  final FightCreatorRepository _fightCreatorRepository;

  ObserveDifficultyUseCase(this._fightCreatorRepository);

  Stream<DifficultyModel> call() => _fightCreatorRepository.observeDifficulty();
}
