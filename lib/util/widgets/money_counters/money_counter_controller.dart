import 'dart:async';

import 'package:alpaka_clicker/money/domain/get_displayable_money_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'money_counter_controller.g.dart';

@injectable
class MoneyCounterController = MoneyCounterControllerBase with _$MoneyCounterController;

abstract class MoneyCounterControllerBase with Store {
  final GetDisplayableMoneyUseCase _displayableMoneyUseCase;

  MoneyCounterControllerBase(this._displayableMoneyUseCase);

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
    _displayableMoneyUseCase()
        .onSuccess((money) => actualMoney = money)
        .onFailure((exception) => actualMoney = ":(");
  }

  void dispose() {
    _moneyUpdater.cancel();
  }
}
