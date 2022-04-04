import 'dart:math';

import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/util/finals.dart';
import 'package:injectable/injectable.dart';

@injectable
class CurrencyBeautifier {
  int _currentPower = 0;
  String _currentSuffix = "";

  final String _dotString = ".";
  final int _placesAfterPoint = 3;
  final int _numberSystemBase = 27;
  final int _charBase = 64;

  String beautifyCurrency(Currency currency) {
    final value = currency.value;
    final power = currency.power;
    if (power == 0) {
      return value.toString()[0];
    } else if (power < _placesAfterPoint) {
      final multipliedValue = value * pow(10, power);
      return multipliedValue.toString().substring(0, multipliedValue.toString().indexOf(_dotString));
    }
    final newPower = power % _placesAfterPoint;
    final multipliedValue = value * pow(10, newPower);
    final multipliedValueString = multipliedValue.toStringAsFixed(4);
    return multipliedValueString.substring(0, multipliedValueString.length - 1) + _getSuffix(power);
  }

  String _getSuffix(int power) {
    if (power == _currentPower) {
      return _currentSuffix;
    }
    _currentPower = power;
    _currentSuffix = _generateSuffix(power);
    return _currentSuffix;
  }

  String _generateSuffix(int power) {
    int suffixPower = (power - _placesAfterPoint) ~/ _placesAfterPoint;
    if (suffixPower == 0) {
      return emptyString;
    }

    String suffix = emptyString;
    while (suffixPower > 0) {
      final positionSuffixPower = (suffixPower % _numberSystemBase);
      suffix = String.fromCharCode(positionSuffixPower + _charBase) + suffix;
      suffixPower ~/= _numberSystemBase;
    }

    return suffix.padLeft(suffix.length + 1);
  }

  String beautifyCurrencyPerSecond(Currency currency) {
    if (currency.value < 1.6666 && currency.power ==0) {
      final newCurrency = currency.value * 60 * pow(10, currency.power);
      return "${newCurrency.toStringAsFixed(1).replaceAll(".", ",")}/s";
    }
    return "${beautifyCurrency(currency.multiplyByDouble(60))}/s";
  }
}
