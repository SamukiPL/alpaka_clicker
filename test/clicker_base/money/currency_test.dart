import 'dart:math';

import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/util/exceptions/currency_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../testUtils/expect_throw.dart';

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

  test("Wrong power in constructor causes error", () {
    try {
      Currency(value: 1, power: -1);
      assert(false);
    } on AssertionError {
      assert(true);
    }
  });

  test("Power is more than 0 when value is 0", () {
    try {
      Currency(value: 0, power: 2);
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

  test("Subtract very big value bigger than 9", () {
    const startPower = 9;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 9.99, power: startPower - 1, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 1);
    expect(currency.power, startPower - 2);
  });

  test("Subtract very big value", () {
    const startPower = 9;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 9, power: startPower - 1, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 1);
    expect(currency.power, startPower - 1);
  });

  test("Subtract very big value smaller than 9", () {
    const startPower = 9;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 8.99, power: startPower - 1, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 1.01);
    expect(currency.power, startPower - 1);
  });

  test("Subtract very small value", () {
    const startPower = 16;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 1, power: 4, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 9.99999999999);
    expect(currency.power, startPower - 1);
  });

  test("Subtract too small value", () {
    const startPower = 16;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 1, power: 0, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 9.999999999999);
    expect(currency.power, startPower - 1);
  });

  test("Subtract bigger value", () {
    const startPower = 3;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 1, power: startPower + 1, preccision: preccision);
    expectThrow(() => currency -= subtract, CannotSubtractException);
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

  test("Subtract idiotic value", () {
    const startPower = 9223372036854775807;
    Currency currency = Currency(value: 1, power: startPower, preccision: preccision);
    Currency subtract = Currency(value: 1, power: startPower - 1, preccision: preccision);
    currency -= subtract;
    expect(currency.value, 9);
    expect(currency.power, startPower - 1);
  });

  test("Add idiotic value", () {
    const startPower = 9223372036854775807;
    Currency currency = Currency(value: 5, power: startPower, preccision: preccision);
    Currency add = Currency(value: 5, power: startPower, preccision: preccision);
    currency += add;
    expect(currency.value, 1);
    expect(currency.power < 0, true);
  });

  test("Add 1/60 for 61 frames", () {
    Currency currency = Currency(value: 0, power: 0, preccision: preccision);
    Currency add = Currency(value: 0.0166666666, power: 0, preccision: preccision);
    for (int i = 0; i <= 60; i++) {
      currency += add;
    }
    expect(currency.value > 1, true);
    expect(currency.power, 0);
  });

  test("Add 1/60 for 601 frames", () {
    Currency currency = Currency(value: 0, power: 0, preccision: preccision);
    Currency add = Currency(value: 0.0166666666, power: 0, preccision: preccision);
    for (int i = 0; i <= 600; i++) {
      currency += add;
    }
    expect(currency.value > 1, true);
    expect(currency.power, 1);
  });

  test("Multiply by 2", () {
    double initialValue = 1;
    int initialPower = 1;
    Currency currency = Currency(value: initialValue, power: initialPower, preccision: preccision);
    double multiplier = 2;
    currency *= multiplier;
    expect(currency.value, initialValue * multiplier);
    expect(currency.power, initialPower);
  });

  test("Multiply by 10", () {
    double initialValue = 1;
    int initialPower = 1;
    Currency currency = Currency(value: initialValue, power: initialPower, preccision: preccision);
    double multiplier = 10;
    currency *= multiplier;
    expect(currency.value, initialValue);
    expect(currency.power, initialPower + 1);
  });

  test("Multiply by 1000", () {
    double initialValue = 1;
    int initialPower = 1;
    Currency currency = Currency(value: initialValue, power: initialPower, preccision: preccision);
    int multiplierPower = 3;
    double multiplier = pow(10, multiplierPower).toDouble();
    currency *= multiplier;
    expect(currency.value, initialValue);
    expect(currency.power, initialPower + multiplierPower);
  });

  test("Multiply by 2 when initial value is 5", () {
    double initialValue = 5;
    int initialPower = 1;
    Currency currency = Currency(value: initialValue, power: initialPower, preccision: preccision);
    double multiplier = 2;
    currency *= multiplier;
    expect(currency.value, 1);
    expect(currency.power, initialPower + 1);
  });

  test("Multiply by 1.5 when initial value is 1", () {
    double initialValue = 5;
    int initialPower = 1;
    Currency currency = Currency(value: initialValue, power: initialPower, preccision: preccision);
    double multiplier = 1.5;
    currency *= multiplier;
    expect(currency.value, initialValue * multiplier);
    expect(currency.power, initialPower);
  });

  test("Multiply by 1500 when initial value is 1", () {
    double initialValue = 5;
    int initialPower = 1;
    Currency currency = Currency(value: initialValue, power: initialPower, preccision: preccision);
    int multiplierPower = 3;
    double multiplier = 1.5 * pow(10, multiplierPower).toDouble();
    currency *= multiplier;
    expect(currency.value, 7.5);
    expect(currency.power, initialPower + multiplierPower);
  });

  test("Multiply by weird number when initial value is weird number", () {
    double initialValue = 2.137;
    int initialPower = 3;
    Currency currency = Currency(value: initialValue, power: initialPower, preccision: preccision);
    int multiplierPower = 4;
    double multiplier = 9.857 * pow(10, multiplierPower).toDouble();
    currency *= multiplier;
    expect(currency.value, 2.1064409);
    expect(currency.power, initialPower + multiplierPower + 1);
  });

  test("Multiply by less than 1", () {
    double initialValue = 1;
    int initialPower = 1;
    Currency currency = Currency(value: initialValue, power: initialPower, preccision: preccision);
    double multiplier = 0.1;
    expectThrow(() => currency *= multiplier, CannotMultiplyException);
  });
}
