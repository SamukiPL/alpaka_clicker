import 'dart:math';

import 'package:alpaka_clicker/util/exceptions/currency_exceptions.dart';
import 'package:alpaka_clicker/util/ext/double_ext.dart';

class Currency {
  double value;
  int power;
  final int preccision;

  Currency({required this.value, required this.power, this.preccision = 12})
      : assert(value < 10),
        assert(power >= 0),
        assert(!(value < 0 && power > 0)) {
    value = value.toPrecision(preccision);
  }

  Currency operator +(Currency currency) {
    final powerDifference = currency.power - power;
    if (powerDifference <= -preccision) {
      return this;
    } else if (powerDifference > 0) {
      power = currency.power;
      value = currency.value + (value * pow(10, -powerDifference));
    } else {
      value += currency.value * pow(10, powerDifference);
    }
    _normalizeIncrease();
    return this;
  }

  void _normalizeIncrease() {
    final length = value.toString().split(".")[0].length - 1;
    value = value.toPrecision(preccision);
    if (length > 0) {
      value /= pow(10, length);
      power += length;
    }
  }

  Currency operator -(Currency currency) {
    if (this < currency) {
      throw CannotSubtractException();
    } else if (this == currency) {
      return Currency(value: 0, power: 0, preccision: preccision);
    }
    final subtractedPower = power - currency.power;
    if (subtractedPower > preccision) {
      return Currency(value: 9.999999999999, power: power - 1, preccision: preccision);
    }
    value = (value * pow(10, subtractedPower)) - currency.value;
    _normalizeSubtract(currency.value);
    return this;
  }

  void _normalizeSubtract(double subtractedValue) {
    if (subtractedValue <= 9) {
      final length = value.toString().split(".")[0].length - 1;
      value /= pow(10, length);
      power -= 1;
    } else {
      final length = subtractedValue.toString().length - 2;
      value *= pow(10, length);
      power -= length;
    }
    value = value.toPrecision(preccision);
  }

  Currency operator *(double multiplier) {
    if (multiplier < 1) {
      throw CannotMultiplyException();
    }
    value *= multiplier;
    _normalizeIncrease();
    return this;
  }

  @override
  bool operator ==(Object other) => other is Currency && power == other.power && value == other.value;

  bool operator >(Currency currency) => power > currency.power || power == currency.power && value > currency.value;

  bool operator >=(Currency currency) => this == currency || this > currency;

  bool operator <(Currency currency) => power < currency.power || power == currency.power && value < currency.value;

  bool operator <=(Currency currency) => this == currency || this < currency;

  @override
  int get hashCode => Object.hashAll([power, value]);
}
