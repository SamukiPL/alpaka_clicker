import 'dart:async';

import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/deposit.dart';
import 'package:alpaka_clicker/clicker_base/money/spend_money_state.dart';
import 'package:alpaka_clicker/util/exceptions/currency_exceptions.dart';

class Bank {
  late final Deposit _deposit;
  Currency _currentSalary;
  Currency _currentInterest;

  Bank(Currency _depositedMoney, this._currentSalary, this._currentInterest) {
    _deposit = Deposit(_depositedMoney);
  }

  Currency getMoney() => _deposit.depositedMoney;

  void depositMoney(Currency currency) {
    _deposit.addMoney(currency);
  }

  Currency getSalary() => _currentSalary;

  void raiseSalary(Currency salary) {
    _currentSalary += salary;
  }

  void paySalary() {
    _deposit.addMoney(_currentSalary);
  }

  Currency getInterest() => _currentInterest;

  void raiseInterest(Currency interest) {
    _currentInterest += interest;
  }

  void payInterest() {
    _deposit.addMoney(_currentInterest);
  }

  void changeInterest(Currency interest) {
    _currentInterest = interest;
  }

  Future<SpendMoneyState> spendMoney(Currency currency, {required FutureOr<void> Function() successReaction}) {
    return Future(() async {
      final locked = _deposit.lock();
      locked.spendMoney(currency);
      return SpendMoneyState.success;
    }).onError((Object error, stackTrace) => _handleSpendMoneyError(error)).then((state) async {
      if (state == SpendMoneyState.success) {
        await successReaction();
      }
      if (state != SpendMoneyState.lockedDeposit) {
        _deposit.unlock();
      }
      return state;
    });
  }

  SpendMoneyState _handleSpendMoneyError(Object error) {
    if (error is CannotSubtractException) {
      return SpendMoneyState.priceIsTooBig;
    } else if (error is StateError) {
      return SpendMoneyState.lockedDeposit;
    } else {
      throw error;
    }
  }
}
