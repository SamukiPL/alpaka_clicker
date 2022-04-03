import 'package:alpaka_clicker/clicker_base/money/currency_beautifier.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../testUtils/mocked_models.dart';

void main() {
  final currencyBeautifier = CurrencyBeautifier();
  test("Currency with power 0 returns its value", () {
    final newCurrency = currency(1, 0);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1");
  });

  test("Currency with power 0 returns its value without numbers after point", () {
    final newCurrency = currency(1.1234, 0);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1");
  });

  test("Currency with value 1 and power 1 returns \"10\"", () {
    final newCurrency = currency(1, 1);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "10");
  });

  test("Currency with value 1 and power 2 returns \"100\"", () {
    final newCurrency = currency(1, 2);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "100");
  });

  test("Currency with value 1.123 and power 2 returns \"112\" without after point numbers", () {
    final newCurrency = currency(1.123, 2);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "112");
  });

  test("Currency with value 1 and power 3 returns \"1.000\"", () {
    final newCurrency = currency(1, 3);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000");
  });

  test("Currency with value 1.123 and power 3 returns \"1.123\"", () {
    final newCurrency = currency(1.123, 3);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.123");
  });

  test("Currency with value 1 and power 4 returns \"10.000\"", () {
    final newCurrency = currency(1, 4);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "10.000");
  });

  test("Currency with value 1 and power 5 returns \"100.000\"", () {
    final newCurrency = currency(1, 5);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "100.000");
  });

  test("Currency with value 1 and power 6 returns \"1.000 A\"", () {
    final newCurrency = currency(1, 6);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 A");
  });

  test("Currency with value 1 and power 84 returns \"1.000 A@\"", () {
    final newCurrency = currency(1, 84);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 A@");
  });

  test("Currency with value 1 and power 87 returns \"1.000 AA\"", () {
    final newCurrency = currency(1, 87);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 AA");
  });

  test("Currency with value 1 and power 90 returns \"1.000 AB\"", () {
    final newCurrency = currency(1, 90);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 AB");
  });

  test("Currency with value 1 and power 156 returns \"1.000 AX\"", () {
    final newCurrency = currency(1, 156);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 AX");
  });

  test("Currency with value 1 and power 159 returns \"1.000 AY\"", () {
    final newCurrency = currency(1, 159);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 AY");
  });

  test("Currency with value 1 and power 162 returns \"1.000 AZ\"", () {
    final newCurrency = currency(1, 162);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 AZ");
  });

  test("Currency with value 1 and power 162 returns \"1.000 AZ\"", () {
    final newCurrency = currency(1, 162);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 AZ");
  });

  test("Currency with value 1 and power 165 returns \"1.000 B@\"", () {
    final newCurrency = currency(1, 165);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 B@");
  });

  test("Currency with value 1.11 and power 166 returns \"11.100 B@\"", () {
    final newCurrency = currency(1.11, 166);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "11.100 B@");
  });

  test("Currency with value 1 and power 167 returns \"111.000 B@\"", () {
    final newCurrency = currency(1.11, 167);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "111.000 B@");
  });

  test("Currency with value 1 and power 2190 returns \"1.000 A@@\"", () {
    final newCurrency = currency(1, 2190);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 A@@");
  });

  test("Currency with value 1 and power 2193 returns \"1.000 A@A\"", () {
    final newCurrency = currency(1, 2193);
    final beautified = currencyBeautifier.beautifyCurrency(newCurrency);
    expect(beautified, "1.000 A@A");
  });

  test("Per second currency with value 0.0016666 and power 0 returns \"0,1/s\"", () {
    final newCurrency = currency(0.0016666, 0);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "0,1/s");
  });

  test("Per second currency with value 0.01 and power 0 returns \"0,6/s\"", () {
    final newCurrency = currency(0.01, 0);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "0,6/s");
  });

  test("Per second currency with value 0.018333 and power 0 returns \"1,1/s\"", () {
    final newCurrency = currency(0.018333, 0);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "1,1/s");
  });

  test("Per second currency with value 0.16833 and power 0 returns \"10,1/s\"", () {
    final newCurrency = currency(0.168333, 0);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "10,1/s");
  });

  test("Per second currency with value 1.665 and power 0 returns \"99,9/s\"", () {
    final newCurrency = currency(1.665, 0);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "99,9/s");
  });

  test("Per second currency with value 1.668333 and power 0 returns \"100/s\"", () {
    final newCurrency = currency(1.668333, 0);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "100/s");
  });

  test("Per second currency with value 1.6665 and power 1 returns \"999/s\"", () {
    final newCurrency = currency(1.6665, 1);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "999/s");
  });

  test("Per second currency with value 1.666666 and power 1 returns \"1.000/s\"", () {
    final newCurrency = currency(1.666667, 1);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "1.000/s");
  });

  test("Per second currency with value 1.666666 and power 4 returns \"1.000 A/s\"", () {
    final newCurrency = currency(1.666667, 4);
    final beautified = currencyBeautifier.beautifyInterestPerSecond(newCurrency);
    expect(beautified, "1.000 A/s");
  });
}
