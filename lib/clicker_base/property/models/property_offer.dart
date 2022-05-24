import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/models/offer.dart';

class PropertyOffer implements Offer {
  final String key;
  final int count;
  @override
  final Currency price;
  final Currency interest;

  const PropertyOffer({required this.key, required this.count, required this.price, required this.interest});

  bool canBeBought(Currency money) {
    return price <= money;
  }
}
