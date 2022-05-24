import 'package:alpaka_clicker/character_base/character/character.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/character_base/personalty/personalty.dart';
import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/flows/character_details/domain/models/personalty_model.dart';
import 'package:alpaka_clicker/util/pair.dart';

class ToPersonaltyModelMapper {
  PersonaltyModel call(Currency currentMoney, Character character, Personalty personalty, PersonaltyOffer offer) =>
      PersonaltyModel(
        personalty.name,
        personalty.level,
        personalty.attributeTag,
        character.getAttributeByTag(personalty.attributeTag).grade,
        Pair(1, 100),//TODO
        offer,
        offer.canBeBought(currentMoney),
      );
}
