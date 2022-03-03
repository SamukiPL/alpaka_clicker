import 'dart:async';

import 'package:alpaka_clicker/money/bank.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'money_counter_controller.g.dart';

@injectable
class MoneyCounterController = MoneyCounterControllerBase with _$MoneyCounterController;

abstract class MoneyCounterControllerBase with Store {
  final Bank _bank;

  MoneyCounterControllerBase(this._bank);

  late Timer _moneyUpdater;

  void initializeMoneyUpdate() {
    _moneyUpdater = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _updateMoney();
    });
  }

  @observable
  String actualMoney = "";

  @action
  Future<void> _updateMoney() async {
    actualMoney = (_bank.getMoney().value * 100).toStringAsPrecision(6) + " AA";
  }

  void dispose() {
    _moneyUpdater.cancel();
  }
}