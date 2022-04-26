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

  test("Bank allows us to spend money and it is success", () async {
    final price = Currency(value: 5, power: 1);
    final bank = bankWithMoney(1.0, 2);
    final result = await bank.spendMoney(price);
    expect(result, SpendMoneyState.success);
    final storedValue = bank.getMoney();
    expect(storedValue.value, 5);
    expect(storedValue.power, 1);
  });

  test("Bank doesn't allows us to spend money and the price is too big", () async {
    final price = Currency(value: 5, power: 2);
    final bank = bankWithMoney(1.0, 2);
    final result = await bank.spendMoney(price);
    expect(result, SpendMoneyState.priceIsTooBig);
    final storedValue = bank.getMoney();
    expect(storedValue.value, 1);
    expect(storedValue.power, 2);
  });

  test("Bank returns SpendMoneyState.lockedDeposit when two actions concurrently tries to spend money", () {
    final price = Currency(value: 1, power: 0);
    final bank = bankWithMoney(1.0, 2);
    Future.value(bank.spendMoney(price)).then(expectAsync1((state) => expect(state, SpendMoneyState.success)));
    Future.value(bank.spendMoney(price)).then(expectAsync1((state) => expect(state, SpendMoneyState.lockedDeposit)));
  });

  test("Bank accepts reaction closure when spending money", () async {
    final price = Currency(value: 1, power: 0);
    final bank = bankWithMoney(1.0, 2);
    bool reactionWasCalled = false;
    await bank.spendMoney(price, reaction: (state) {
      reactionWasCalled = true;
    });
    assert(reactionWasCalled);
  });

  test("Bank calls reaction before unlocking deposit", () async {
    final price = Currency(value: 1, power: 0);
    final bank = bankWithMoney(1.0, 2);
    final returned = await bank.spendMoney(price, reaction: (state) async {
      expect(state, SpendMoneyState.success);
      final shouldBeLockedState = await bank.spendMoney(price);
      expect(shouldBeLockedState, SpendMoneyState.lockedDeposit);
    });
    expect(returned, SpendMoneyState.success);
  });

  test("Bank should only unlock when action was successful or too big to process", () async {
    final price = Currency(value: 1, power: 0);
    final tooBigPrice = Currency(value: 1, power: 3);
    final bank = bankWithMoney(1.0, 2);
    await bank.spendMoney(price, reaction: (state) async {
      final firstLocked = await bank.spendMoney(price);
      expect(firstLocked, SpendMoneyState.lockedDeposit);
      final secondLocked = await bank.spendMoney(price);
      expect(secondLocked, SpendMoneyState.lockedDeposit);
    });
    await bank.spendMoney(tooBigPrice, reaction: (state) async {
      final shouldBeLockedState = await bank.spendMoney(price);
      expect(shouldBeLockedState, SpendMoneyState.lockedDeposit);
    });
    final depositUnlockedShouldBeSuccess = await bank.spendMoney(price);
    expect(depositUnlockedShouldBeSuccess, SpendMoneyState.success);
  });

  test("Full bank functionalities", () async {
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
    final firstResult = await bank.spendMoney(creamPiePrice);
    expect(firstResult, SpendMoneyState.success);
    expect(bank.getMoney(), emptyCurrency());

    final secondResult = await bank.spendMoney(creamPiePrice);
    expect(secondResult, SpendMoneyState.priceIsTooBig);

    expect(bank.getMoney(), emptyCurrency());
    expect(bank.getSalary(), salaryRise);
    expect(bank.getInterest(), interestRise);
  });
}
