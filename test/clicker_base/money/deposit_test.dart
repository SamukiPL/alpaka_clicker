import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/deposit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../testUtils/expect_throw.dart';
import '../../testUtils/mocked_models.dart';

void main() {
  test("Can create Deposit class with currency in constructor", () {
    Deposit(emptyCurrency());
  });

  test("Deposit returns depositedMoney in getter", () {
    final depositedMoney = currency(1, 1);
    final underTest = Deposit(depositedMoney);
    Currency returned = underTest.depositedMoney;
    expect(returned.value, depositedMoney.value);
    expect(returned.power, depositedMoney.power);
  });

  test("Deposit can add more to its deposit", () {
    final newMoney = currency(1, 1);
    final underTest = Deposit(emptyCurrency());
    underTest.addMoney(newMoney);
  });

  test("Deposit can check if it is locked and it starts as false", () {
    final underTest = Deposit(emptyCurrency());
    expect(underTest.isLocked, false);
  });

  test("Deposit can be locked", () {
    final underTest = Deposit(emptyCurrency());
    underTest.lock();
    expect(underTest.isLocked, true);
  });

  test("Deposit can be locked and throws when already locked", () {
    final underTest = Deposit(emptyCurrency());
    underTest.lock();
    expectThrow(() => underTest.lock(), StateError);
  });

  test("Deposit can be locked and throws when already locked", () {
    final underTest = Deposit(emptyCurrency());
    underTest.lock();
    expectThrow(() => underTest.lock(), StateError);
  });

  test("Deposit can be unlocked after locking", () {
    final underTest = Deposit(emptyCurrency());
    underTest.lock();
    expect(underTest.isLocked, true);
    underTest.unlock();
    expect(underTest.isLocked, false);
  });

  test("Deposit returns _LockedDeposit when locking and can spend its money", () {
    final startCurrency = currency(2, 0);
    final price = currency(1, 0);
    final underTest = Deposit(startCurrency);
    final locked = underTest.lock();
    locked.spendMoney(price);
    expect(underTest.depositedMoney, startCurrency - price);
  });
}
