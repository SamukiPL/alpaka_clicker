import 'package:alpaka_clicker/flows/property_shop/domain/change_buy_amount_use_case.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';

part 'buy_controls_controller.g.dart';

@injectable
class BuyControlsController = BuyControlsControllerBase with _$BuyControlsController;

abstract class BuyControlsControllerBase with Store {
  final ChangeBuyAmountUseCase _changeBuyAmountUseCase;

  @observable
  BuyAmount selected = BuyAmount.one;

  BuyControlsControllerBase(this._changeBuyAmountUseCase);

  Future<void> setSelected(BuyAmount control) async {
    try {
      await _changeBuyAmountUseCase(control);
      selected = control;
    } catch (e) {
      Logger.root.shout(e);
    }
  }
}
