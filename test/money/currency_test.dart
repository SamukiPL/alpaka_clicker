import 'package:alpaka_clicker/money/currency.dart';
import 'package:flutter_test/flutter_test.dart';

import '../testUtils/expect_throw.dart';

main() {
  const preccision = 12;
  test("Wrong value in constructor causes error", () {
    try {
      Currency(value: 100, power: 1);
      assert(false);
    } on AssertionError {
      assert(true);
    }
  });

  test("Value is normalized to only 9 places after decimal", () {
    const value = 1.987654321123456789;
    const power = 12;
    final currency = Currency(value: value, power: power, preccision: preccision);
    expect(currency.value, 1.987654321123);
    expect(currency.power, power);
  });

  test("Value is always lower than 10", () {
    const value = 9.9;
    const power = 3;
    final currency = Currency(value: value, power: power, preccision: preccision);
    expect(currency.value, value);
    expect(currency.power, power);
  });

  test("Add smaller value", () {
    Currency currency = Currency(value: 1, power: 3, preccision: preccision);
    final add = Currency(value: 1, power: 2, preccision: preccision);
    currency += add;
    expect(currency.value, 1.1);
    expect(currency.power, 3);
  });

  test("Add very small value", () {
    Currency currency = Currency(value: 1.00001, power: 9, preccision: preccision);
    final add = Currency(value: 1, power: 2, preccision: preccision);
    currency += add;
    expect(currency.value, 1.0000101);
    expect(currency.power, 9);
  });

  test("Add too small value", () {
    const power = 16;
    Currency currency = Currency(value: 1.00001, power: power, preccision: preccision);
    final add = Currency(value: 1, power: power - preccision, preccision: preccision);
    currency += add;
    expect(currency.value, 1.00001);
    expect(currency.power, power);
  });

  test("Add bigger value", () {
    Currency currency = Currency(value: 1, power: 2, preccision: preccision);
    final add = Currency(value: 1, power: 3, preccision: preccision);
    currency += add;
    expect(currency.value, 1.1);
    expect(currency.power, add.power);
  });

  test("Add very big value", () {
    Currency currency = Currency(value: 1.01, power: 2, preccision: preccision);
    final add = Currency(value: 1.01, power: 9, preccision: preccision);
    currency += add;
    expect(currency.value, 1.010000101);
    expect(currency.power, add.power);
  });

  test("Add too big value", () {
    Currency currency = Currency(value: 1, power: 2, preccision: preccision);
    final add = Currency(value: 1, power: 16, preccision: preccision);
    currency += add;
    expect(currency.value, add.value);
    expect(currency.power, add.power);
  });

  test("Add values that will bump power up", () {
    Currency currency = Currency(value: 5, power: 2, preccision: preccision);
    final add = Currency(value: 5, power: 2, preccision: preccision);
    currency += add;
    expect(currency.value, 1);
    expect(currency.power, 3);
  });

  test("Add values that will bump power up with weird result", () {
    Currency currency = Currency(value: 9.685, power: 6, preccision: preccision);
    final add = Currency(value: 3.98324, power: 6, preccision: preccision);
    currency += add;
    expect(currency.value, 1.366824);
    expect(currency.power, 7);
  });

  test("Subtract smaller value", () {
    const startPower = 3;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 1, power: 2, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 9);
    expect(currency.power, startPower - 1);
  });

  test("Subtract very small value", () {
    const startPower = 9;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 1, power: 2, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 9.999999);
    expect(currency.power, startPower - 1);
  });

  test("Subtract very big value", () {
    const startPower = 9;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 9.99, power: startPower - 1, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 1);
    expect(currency.power, startPower - 2);
  });

  test("Subtract bigger value", () {
    const startPower = 3;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 1, power: startPower + 1, preccision: preccision);
    expectThrow(() => currency -= subtract, ArgumentError);
    expect(currency.value, 1);
    expect(currency.power, startPower);
  });

  test("Subtract same value", () {
    const startPower = 3;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: currency.value, power: currency.power, preccision: currency.preccision);
    currency -= subtract;
    expect(currency.value, 0);
    expect(currency.power, 0);
  });
}