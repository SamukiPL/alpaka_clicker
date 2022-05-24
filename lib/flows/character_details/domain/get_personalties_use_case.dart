import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';
import 'package:alpaka_clicker/util/monad/result.dart';

class GetPersonaltiesUseCase {
  final CharacterDetailsRepository _repository;

  GetPersonaltiesUseCase(this._repository);

  Stream<Result<List<PersonaltyModel>>> call() => _repository.getPersonaltiesList();
}
