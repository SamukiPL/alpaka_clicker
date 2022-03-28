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
    return _normalizeSubtract(currency.value, newValue, power);
  }

  Currency _normalizeSubtract(double subtractedValue, double value, int power) {
    double newValue = value;
    int newPower = power;
    if (subtractedValue <= 9) {
      final length = value.toString().split(".")[0].length - 1;
      newValue /= pow(10, length);
      newPower -= 1;
    } else {
      final length = subtractedValue.toString().length - 2;
      newValue *= pow(10, length);
      newPower -= length;
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
