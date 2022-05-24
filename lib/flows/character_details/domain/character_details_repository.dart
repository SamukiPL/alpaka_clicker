import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/character_info_model.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';
import 'package:alpaka_clicker/util/monad/result.dart';

abstract class CharacterDetailsRepository {
  Future<CharacterInfoModel> getCharacterInfo();

  Stream<Result<List<PersonaltyModel>>> getPersonaltiesList();

  Future<void> levelUpAttribute(AttributeTag tag);
}
