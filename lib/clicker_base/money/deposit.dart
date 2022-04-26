import 'package:alpaka_clicker/clicker_base/money/currency.dart';

class Deposit {
  Currency _depositedMoney;

  Deposit(this._depositedMoney);

  _LockedDeposit? _locked;
  bool get isLocked => _locked != null;

  Currency get depositedMoney => _depositedMoney;

  void addMoney(Currency newMoney) {
    _depositedMoney += newMoney;
  }

  _LockedDeposit lock() {
    if (isLocked) throw StateError("Deposit is already locked!");
    _locked = _LockedDeposit(this);
    return _locked!;
  }

  void unlock() {
    _locked = null;
  }
}

class _LockedDeposit {
  final Deposit _deposit;

  _LockedDeposit(this._deposit);

  void spendMoney(Currency currency) {
    _deposit._depositedMoney -= currency;
  }
}
