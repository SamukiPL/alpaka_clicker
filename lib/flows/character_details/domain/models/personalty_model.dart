import 'package:alpaka_clicker/character_base/character/models/attributes.dart';
import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
import 'package:alpaka_clicker/util/pair.dart';

class PersonaltyModel {
  final String name;
  final int currentLevel;
  final AttributeTag attributeTag;
  final Grade attributeGrade;
  final Range attributeRange;
  final String displayablePrice;
  final PersonaltyOffer offer;
  final bool canBuy;

  PersonaltyModel(this.name, this.currentLevel, this.attributeTag, this.attributeGrade, this.attributeRange,
      this.displayablePrice, this.offer, this.canBuy);
}
