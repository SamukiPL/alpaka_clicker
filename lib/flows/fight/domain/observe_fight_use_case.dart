import 'package:alpaka_clicker/flows/fight/domain/fight_repository.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/fight_details_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ObserveFightUseCase {
  final FightRepository _repository;

  ObserveFightUseCase(this._repository);

  Stream<FightDetailsModel> call() => _repository.observeFight();
}
