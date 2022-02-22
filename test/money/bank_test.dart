import 'package:alpaka_clicker/money/bank.dart';
import 'package:alpaka_clicker/money/currency.dart';
import 'package:alpaka_clicker/money/spend_money_state.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Bank returns deposited currency", () {
    const value = 1.0;
    const power = 2;
    final bank = bankWithMoney(value, power);
    final storedValue = bank.getMoney();
    expect(storedValue.value, value);
    expect(storedValue.power, power);
  });

  test("Bank deposits currency", () {
    final bank = emptyBank();
    final currency = Currency(value: 1, power: 1);
    bank.depositMoney(currency);
    final storedValue = bank.getMoney();
    expect(storedValue, currency);
  });

  test("Bank returns current Interest", () {
    final bank = emptyBank();
    Currency interest = bank.getInterest();
    expect(interest.value, 0);
    expect(interest.power, 0);
  });

  test("Bank returns interest passed by constructor", () {
    final interest = Currency(value: 1.4, power: 4);
    final bank = Bank(Currency(value: 0.0, power: 0), interest);
    final returnedInterest = bank.getInterest();
    expect(returnedInterest, interest);
  });

  test("Bank accepts raising interest", () {
    final interest = Currency(value: 1.1, power: 2);
    final bank = emptyBank();
    bank.raiseInterest(interest);
    final returnedInterest = bank.getInterest();
    expect(returnedInterest, interest);
  });

  test("Bank pays interest every metod invokation", () {
    final interest = Currency(value: 1.1, power: 2);
    final bank = emptyBank();
    bank.raiseInterest(interest);
    bank.payInterest();
    final storedValue = bank.getMoney();
    expect(storedValue, interest);
  });

  test("Bank pays interest of 1/60 for 61 frames", () {
    final interest = Currency(value: 0.0166666666, power: 0);
    final bank = emptyBank();
    bank.raiseInterest(interest);
    for(int i = 0; i <= 60; i++) {
      bank.payInterest();
    }
    final storedValue = bank.getMoney();
    expect(storedValue.value > 1, true);
    expect(storedValue.power, 0);
  });

  test("Bank allows us to spend money and it is success", () {
    final price = Currency(value: 5, power: 1);
    final bank = bankWithMoney(1.0, 2);
    final result = bank.spendMoney(price);
    expect(result , SpendMoneyState.success);
    final storedValue = bank.getMoney();
    expect(storedValue.value, 5);
    expect(storedValue.power, 1);
  });

  test("Bank doesn't allows us to spend money and the price is too big", () {
    final price = Currency(value: 5, power: 2);
    final bank = bankWithMoney(1.0, 2);
    final result = bank.spendMoney(price);
    expect(result , SpendMoneyState.priceIsTooBig);
    final storedValue = bank.getMoney();
    expect(storedValue.value, 1);
    expect(storedValue.power, 2);
  });
}

Bank emptyBank() => Bank(Currency(value: 0.0, power: 0), Currency(value: 0.0, power: 0));
Bank bankWithMoney(double value, int power) => Bank(Currency(value: value, power: power), Currency(value: 0.0, power: 0));
Bank bankWithInterest(double value, int power) => Bank(Currency(value: 0.0, power: 0), Currency(value: value, power: power));