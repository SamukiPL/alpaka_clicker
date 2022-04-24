import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';

class Property {
  final String key;
  final String name;
  int count;
  final Currency baseIncrementation;
  final Currency basePrice;
  Currency baseInterest;

  late Currency _currentIncrementation;

  Property({
    required this.key,
    required this.name,
    required this.count,
    required this.baseIncrementation,
    required this.basePrice,
    required this.baseInterest,
  }) {
    _currentIncrementation = baseIncrementation.powByExponent(count);
  }

  PropertyOffer getOffer({int offerCount = 1}) {
    Currency price = basePrice * _currentIncrementation;
    for (int i = 1; i < offerCount; i++) {
      price += generatePrice(i);
    }
    final interest = baseInterest.multiplyByDouble(offerCount.toDouble());
    return PropertyOffer(key: key, count: offerCount, price: price, interest: interest);
  }

  Currency generatePrice(int iteration) {
    return basePrice * _currentIncrementation * baseIncrementation.powByExponent(iteration);
  }

  void addPurchased(int addend) {
    count += addend;
    _currentIncrementation *= baseIncrementation.powByExponent(addend);
  }

  void multiplyInterest(double interestMultiplier) => baseInterest = baseInterest.multiplyByDouble(interestMultiplier);

  Currency getCurrentInterest() => baseInterest.multiplyByDouble(count.toDouble());
}
