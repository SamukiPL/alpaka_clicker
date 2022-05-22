import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/character_info_model.dart';

class GetCharacterInfoUseCase {
  final CharacterDetailsRepository _repository;

  GetCharacterInfoUseCase(this._repository);

  Future<CharacterInfoModel> call() => _repository.getCharacterInfo();
}
