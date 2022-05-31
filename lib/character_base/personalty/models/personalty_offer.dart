import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/models/offer.dart';

class PersonaltyOffer implements Offer {
  final String key;
  @override
  final Currency price;

  PersonaltyOffer(this.key, this.price);

  bool canBeBought(Currency money) {
    return price <= money;
  }
}
