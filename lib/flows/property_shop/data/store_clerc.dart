import 'dart:collection';

import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreClerc {
  final ListQueue<Currency> _prices = ListQueue();

  ListQueue<Currency> get getCurrentPricesQueue => ListQueue.from(_prices);

  bool canAffordNewItem(Currency moneyOwned) {
    final changedSize = _prices.takeWhile((price) => price <= moneyOwned).length;
    if (changedSize > 0) {
      _prices.removeWhere((price) => price <= moneyOwned);
    }
    return changedSize > 0;
  }

  void updateCurrentOffers(Iterable<PropertyOffer> offers, Currency moneyOwned) {
    final sortedOffers = offers.map((e) => e.price).takeWhile((price) => price > moneyOwned).toList()..sort();
    _prices.clear();
    _prices.addAll(sortedOffers);
  }
}
