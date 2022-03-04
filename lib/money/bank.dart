import 'package:alpaka_clicker/money/currency.dart';
import 'package:alpaka_clicker/money/spend_money_state.dart';
import 'package:alpaka_clicker/util/exceptions/currency_exceptions.dart';

class Bank {
  Currency _depositedMoney;
  Currency _currentSalary;
  Currency _currentInterest;

  Bank(this._depositedMoney, this._currentSalary, this._currentInterest);

  Currency getMoney() => _depositedMoney;

  void depositMoney(Currency currency) {
    _depositedMoney += currency;
  }

  SpendMoneyState spendMoney(Currency currency) {
    try {
      _depositedMoney -= currency;
      return SpendMoneyState.success;
    } on CannotSubtractException {
      return SpendMoneyState.priceIsTooBig;
    }
  }

  Currency getSalary() => _currentSalary;

  void raiseSalary(Currency salary) {
    _currentSalary += salary;
  }

  void paySalary() {
    _depositedMoney += _currentSalary;
  }

  Currency getInterest() => _currentInterest;

  void raiseInterest(Currency interest) {
    _currentInterest += interest;
  }

  void payInterest() {
    _depositedMoney += _currentInterest;
  }

  void changeInterest(Currency interest) {
    _currentInterest = interest;
  }
}