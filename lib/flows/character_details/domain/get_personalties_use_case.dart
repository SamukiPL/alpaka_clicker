import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';

class GetPersonaltiesUseCase {
  final CharacterDetailsRepository _repository;

  GetPersonaltiesUseCase(this._repository);

  Stream<List<PersonaltyModel>> call() => _repository.getPersonaltiesList();
}
