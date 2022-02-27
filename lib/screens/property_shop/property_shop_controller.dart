import 'dart:async';

import 'package:alpaka_clicker/money/bank.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'property_shop_controller.g.dart';

@injectable
class PropertyShopController = PropertyShopControllerBase with _$PropertyShopController;

abstract class PropertyShopControllerBase with Store {
  final Bank _bank;

  PropertyShopControllerBase(this._bank);

  late Timer _moneyUpdater;

  void initializeMoneyUpdate() {
    _moneyUpdater = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _updateMoney();
    });
  }

  @observable
  String actualMoney = "";

  @action
  Future<void> _updateMoney() async {
    actualMoney = _bank.getMoney().value.toString();
  }

  void dispose() {
    _moneyUpdater.cancel();
  }
}