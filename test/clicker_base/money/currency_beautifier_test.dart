import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/currency_beautifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final currencyBeautifier = CurrencyBeautifier();
  test("Currency with power 0 returns its value", () {
    final currency = newCurrency(1, 0);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1");
  });

  test("Currency with power 0 returns its value without numbers after point", () {
    final currency = newCurrency(1.1234, 0);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1");
  });

  test("Currency with value 1 and power 1 returns \"10\"", () {
    final currency = newCurrency(1, 1);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "10");
  });

  test("Currency with value 1 and power 2 returns \"100\"", () {
    final currency = newCurrency(1, 2);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "100");
  });

  test("Currency with value 1.123 and power 2 returns \"112\" without after point numbers", () {
    final currency = newCurrency(1.123, 2);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "112");
  });

  test("Currency with value 1 and power 3 returns \"1.000\"", () {
    final currency = newCurrency(1, 3);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000");
  });

  test("Currency with value 1.123 and power 3 returns \"1.123\"", () {
    final currency = newCurrency(1.123, 3);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.123");
  });

  test("Currency with value 1 and power 4 returns \"10.000\"", () {
    final currency = newCurrency(1, 4);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "10.000");
  });

  test("Currency with value 1 and power 5 returns \"100.000\"", () {
    final currency = newCurrency(1, 5);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "100.000");
  });

  test("Currency with value 1 and power 6 returns \"1.000 A\"", () {
    final currency = newCurrency(1, 6);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 A");
  });

  test("Currency with value 1 and power 84 returns \"1.000 A@\"", () {
    final currency = newCurrency(1, 84);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 A@");
  });

  test("Currency with value 1 and power 87 returns \"1.000 AA\"", () {
    final currency = newCurrency(1, 87);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 AA");
  });

  test("Currency with value 1 and power 90 returns \"1.000 AB\"", () {
    final currency = newCurrency(1, 90);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 AB");
  });

  test("Currency with value 1 and power 156 returns \"1.000 AX\"", () {
    final currency = newCurrency(1, 156);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 AX");
  });

  test("Currency with value 1 and power 159 returns \"1.000 AY\"", () {
    final currency = newCurrency(1, 159);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 AY");
  });

  test("Currency with value 1 and power 162 returns \"1.000 AZ\"", () {
    final currency = newCurrency(1, 162);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 AZ");
  });

  test("Currency with value 1 and power 162 returns \"1.000 AZ\"", () {
    final currency = newCurrency(1, 162);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 AZ");
  });

  test("Currency with value 1 and power 165 returns \"1.000 B@\"", () {
    final currency = newCurrency(1, 165);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 B@");
  });

  test("Currency with value 1.11 and power 166 returns \"11.100 B@\"", () {
    final currency = newCurrency(1.11, 166);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "11.100 B@");
  });

  test("Currency with value 1 and power 167 returns \"111.000 B@\"", () {
    final currency = newCurrency(1.11, 167);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "111.000 B@");
  });

  test("Currency with value 1 and power 2190 returns \"1.000 A@@\"", () {
    final currency = newCurrency(1, 2190);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 A@@");
  });

  test("Currency with value 1 and power 2193 returns \"1.000 A@A\"", () {
    final currency = newCurrency(1, 2193);
    final beautified = currencyBeautifier.beautifyCurrency(currency);
    expect(beautified, "1.000 A@A");
  });
}

Currency emptyCurrency() => Currency(value: 0.0, power: 0);

Currency newCurrency(double value, int power) =>
    Currency(value: value, power: power);
