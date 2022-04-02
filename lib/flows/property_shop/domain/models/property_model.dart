import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';

class PropertyModel {
  final String name;
  final String displayablePrice;
  final String displayableIncome;
  final int count;
  final PropertyOffer offer;
  final bool canBuy;

  PropertyModel({
    required this.name,
    required this.displayablePrice,
    required this.displayableIncome,
    required this.count,
    required this.offer,
    required this.canBuy,
  });
}
