import 'package:alpaka_clicker/flows/fight/domain/fight_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MakeTurnUseCase {
  final FightRepository _repository;

  MakeTurnUseCase(this._repository);

  Future<void> call() => _repository.makeTurn();
}
