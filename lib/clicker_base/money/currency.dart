import 'dart:math';

import 'package:alpaka_clicker/util/exceptions/currency_exceptions.dart';
import 'package:alpaka_clicker/util/ext/double_ext.dart';

class Currency implements Comparable<Currency> {
  late final double _value;
  final int power;
  final int preccision;

  double get value => _value;

  Currency({required double value, required this.power, this.preccision = 12})
      : assert(value < 10),
        assert(power >= 0),
        assert(!(value < 0 && power > 0)) {
    _value = value.toPrecision(preccision);
  }

  Currency operator +(Currency currency) {
    double newValue = value;
    int newPower = power;
    final powerDifference = currency.power - power;
    if (powerDifference <= -preccision) {
      return this;
    } else if (powerDifference > 0) {
      newPower = currency.power;
      newValue = currency.value + (value * pow(10, -powerDifference));
    } else {
      newValue += currency.value * pow(10, powerDifference);
    }
    return _normalizeIncrease(newValue, newPower);
  }

  Currency _normalizeIncrease(double value, int power) {
    double newValue = value;
    int newPower = power;
    final length = value.toString().split(".")[0].length - 1;
    newValue = value.trimToOnePlaceBeforePoint().toPrecision(preccision);
    if (length > 0) {
      newPower += length;
    }
    return Currency(value: newValue, power: newPower);
  }

  Currency operator -(Currency currency) {
    double newValue = value;
    if (this < currency) {
      throw CannotSubtractException();
    } else if (this == currency) {
      return Currency(value: 0, power: 0, preccision: preccision);
    }
    final subtractedPower = power - currency.power;
    if (subtractedPower > preccision) {
      return Currency(value: 9.999999999999, power: power - 1, preccision: preccision);
    }
    newValue = (value * pow(10, subtractedPower)) - currency.value;
    int newPower = power - ((subtractedPower > 0 && value <= currency.value) ? 1 : 0);
    return _normalizeSubtract(subtractedPower, newValue, newPower);
  }

  Currency _normalizeSubtract(int subtractedPower, double value, int power) {
    double newValue = value.toPrecision(preccision);
    int newPower = power;
    if (newValue >= 1) {
      final length = value.toString().split(".")[0].length - 1;
      newValue /= pow(10, length);
    } else {
      while (newValue < 1 && newPower > 0) {
        newValue *= 10;
        newPower -= 1;
      }
    }
    return Currency(value: newValue, power: newPower);
  }

  Currency operator *(Currency currency) {
    double newValue = value * currency.value;
    int newPower = power + currency.power;
    return _normalizeIncrease(newValue, newPower);
  }

  Currency multiplyByDouble(double multiplier) {
    if (multiplier < 1) {
      throw CannotMultiplyException();
    }
    double newValue = value * multiplier;
    return _normalizeIncrease(newValue, power);
  }

  Currency powByExponent(int exponent) {
    if (exponent < 0) {
      throw CannotPowException();
    } else if (exponent == 0) {
      return Currency(value: 1, power: 0);
    }
    Currency powCurrency = this;
    for (int i = 1; i < exponent; i++) {
      powCurrency *= this;
    }
    return powCurrency;
  }

  Currency ceil() {
    final newValue = value.trimAfterPoint(place: power);
    return Currency(value: newValue, power: power);
  }

  @override
  bool operator ==(Object other) => other is Currency && power == other.power && value == other.value;

  bool operator >(Currency currency) => power > currency.power || power == currency.power && value > currency.value;

  bool operator >=(Currency currency) => this == currency || this > currency;

  bool operator <(Currency currency) => power < currency.power || power == currency.power && value < currency.value;

  bool operator <=(Currency currency) => this == currency || this < currency;

  @override
  int get hashCode => Object.hashAll([power, value]);

  @override
  int compareTo(Currency other) {
    if (this < other) {
      return -1;
    } else if (this == other) {
      return 0;
    } else {
      return 1;
    }
  }
}
