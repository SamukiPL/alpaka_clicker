import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/character_info_model.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';

abstract class CharacterDetailsRepository {
  Future<CharacterInfoModel> getCharacterInfo();

  Stream<List<PersonaltyModel>> getPersonaltiesList();

  Future<void> levelUpAttribute(AttributeTag tag);

  Future<void> buyPersonalityLevel(PersonaltyOffer offer);
}
