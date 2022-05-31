import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/character/models/in_game_level.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/clicker_base/money/currency.dart';

class Personalty {
  final String key;
  final String name;
  InGameLevel _level;
  final int basePricePower;
  final AttributeTag attributeTag;

  Personalty(this.key, this.name, this._level, this.basePricePower, this.attributeTag);

  int get level => _level.level;
  int get experience => _level.experience;
  int get requiredExperience => _level.experienceStrategy;

  Currency get price => Currency(value: 1, power: basePricePower + level);

  void levelUpExternally() {
    _level += requiredExperience;
  }

  void addExperience(int newExperience) {
    _level += newExperience;
  }

  PersonaltyOffer getOffer() => PersonaltyOffer(key, price);
}
