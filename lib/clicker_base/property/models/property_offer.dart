import 'package:alpaka_clicker/clicker_base/money/currency.dart';

class PropertyOffer {
  final String key;
  final int count;
  final Currency price;
  final Currency interest;

  PropertyOffer({required this.key, required this.count, required this.price, required this.interest});
}
