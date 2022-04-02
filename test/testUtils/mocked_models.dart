import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';

Bank emptyBank() => Bank(emptyCurrency(), emptyCurrency(), emptyCurrency());

Bank bankWithMoney(double value, int power) => Bank(currency(value, power), emptyCurrency(), emptyCurrency());

Bank bankWithInterest(double value, int power) => Bank(emptyCurrency(), emptyCurrency(), currency(value, power));

Bank bankWithSalary(double value, int power) => Bank(emptyCurrency(), currency(value, power), emptyCurrency());

Currency emptyCurrency() => Currency(value: 0.0, power: 0);

Currency currency(double value, int power) => Currency(value: value, power: power);

Property emptyProperty() => Property(
    key: "", count: 0, baseIncrementation: emptyCurrency(), basePrice: emptyCurrency(), baseInterest: emptyCurrency());

PropertyOffer emptyPropertyOffer() =>
    PropertyOffer(key: "", count: 1, price: emptyCurrency(), interest: emptyCurrency());
