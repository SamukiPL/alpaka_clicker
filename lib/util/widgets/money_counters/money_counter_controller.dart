import 'dart:async';

import 'package:alpaka_clicker/clicker_base/money/domain/get_displayable_money_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'money_counter_controller.g.dart';

@singleton
class MoneyCounterController = MoneyCounterControllerBase with _$MoneyCounterController;

abstract class MoneyCounterControllerBase with Store {
  final GetDisplayableMoneyUseCase _displayableMoneyUseCase;

  MoneyCounterControllerBase(this._displayableMoneyUseCase);

  late StreamSubscription _moneyDisplaySubscription;

  void initializeMoneyUpdate() {
    _startUpdatingMoney();
  }

  @observable
  String actualMoney = "";

  @action
  Future<void> _startUpdatingMoney() async {
    _moneyDisplaySubscription = _displayableMoneyUseCase().listen((result) {
      result.onSuccess((money) => actualMoney = money).onFailure((exception) => actualMoney = ":(");
    });
  }

  void dispose() {
    _moneyDisplaySubscription.cancel();
  }
}
