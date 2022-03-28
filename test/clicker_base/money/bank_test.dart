import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/spend_money_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../testUtils/mocked_models.dart';

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
    final bank =
        Bank(Currency(value: 0.0, power: 0), emptyCurrency(), interest);
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
    for (int i = 0; i <= 60; i++) {
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
    expect(result, SpendMoneyState.success);
    final storedValue = bank.getMoney();
    expect(storedValue.value, 5);
    expect(storedValue.power, 1);
  });

  test("Bank doesn't allows us to spend money and the price is too big", () {
    final price = Currency(value: 5, power: 2);
    final bank = bankWithMoney(1.0, 2);
    final result = bank.spendMoney(price);
    expect(result, SpendMoneyState.priceIsTooBig);
    final storedValue = bank.getMoney();
    expect(storedValue.value, 1);
    expect(storedValue.power, 2);
  });

  test("Bank returns salary", () {
    final salary = Currency(value: 5, power: 2);
    final bank = Bank(emptyCurrency(), salary, emptyCurrency());
    expect(bank.getSalary(), salary);
  });

  test("Bank accepts salary raise", () {
    final salary = Currency(value: 5, power: 2);
    final bank = emptyBank();
    bank.raiseSalary(salary);
    expect(bank.getSalary(), salary);
  });

  test("Bank accepts salary raise", () {
    const salaryValue = 1.5;
    const salaryPower = 1;
    final bank = bankWithSalary(salaryValue, salaryPower);
    bank.paySalary();
    expect(bank.getMoney().value, salaryValue);
    expect(bank.getMoney().power, salaryPower);
  });

  test("Full bank functionalities", () {
    final bank = emptyBank();

    expect(bank.getMoney(), emptyCurrency());
    expect(bank.getSalary(), emptyCurrency());
    expect(bank.getInterest(), emptyCurrency());

    final moneyToDeposit = currency(0.13, 4);
    final salaryRise = currency(2, 4);
    final interestRise = currency(7, 1);

    bank.depositMoney(moneyToDeposit);
    expect(bank.getMoney(), moneyToDeposit);

    bank.raiseSalary(salaryRise);
    expect(bank.getSalary(), salaryRise);

    bank.raiseInterest(interestRise);
    expect(bank.getInterest(), interestRise);

    bank.paySalary();
    expect(bank.getMoney(), currency(0.13, 4) + currency(2, 4));

    bank.payInterest();
    final allCurrenciesCombined = moneyToDeposit + salaryRise + interestRise;
    expect(bank.getMoney().value, allCurrenciesCombined.value);
    expect(bank.getMoney().power, allCurrenciesCombined.power);

    final creamPiePrice = currency(2.137, 4);
    final firstResult = bank.spendMoney(creamPiePrice);
    expect(firstResult, SpendMoneyState.success);
    expect(bank.getMoney(), emptyCurrency());

    final secondResult = bank.spendMoney(creamPiePrice);
    expect(secondResult, SpendMoneyState.priceIsTooBig);

    expect(bank.getMoney(), emptyCurrency());
    expect(bank.getSalary(), salaryRise);
    expect(bank.getInterest(), interestRise);
  });

  test("Change interest in bank", () {
    const initialValue = 2.0;
    const initialPower = 3;
    final bank = bankWithInterest(initialValue, initialPower);

    const newValue = 1.0;
    const newPower = 7;
    final newCurrency = currency(newValue, newPower);

    bank.changeInterest(newCurrency);
    expect(bank.getInterest().value, newValue);
    expect(bank.getInterest().power, newPower);
  });
}
