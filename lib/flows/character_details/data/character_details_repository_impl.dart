import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/character_details/domain/character_details_repository.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/character_info_model.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CharacterDetailsRepository)
class CharacterDetailsRepositoryImpl implements CharacterDetailsRepository {
  @override
  Future<CharacterInfoModel> getCharacterInfo() {
    // TODO: implement getCharacterInfo
    throw UnimplementedError();
  }

  @override
  Stream<List<PersonaltyModel>> getPersonaltiesList() {
    // TODO: implement getUpgradesList
    throw UnimplementedError();
  }

  @override
  Future<void> levelUpAttribute(AttributeTag tag) {
    // TODO: implement levelUpAttribute
    throw UnimplementedError();
  }
}
