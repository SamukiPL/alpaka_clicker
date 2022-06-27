import 'package:alpaka_clicker/flows/property_shop/domain/change_buy_amount_use_case.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';

part 'buy_controls_controller.g.dart';

@injectable
class BuyControlsController = _BuyControlsControllerBase with _$BuyControlsController;

abstract class _BuyControlsControllerBase with Store {
  final ChangeBuyAmountUseCase _changeBuyAmountUseCase;

  @observable
  BuyAmount selected = BuyAmount.one;

  _BuyControlsControllerBase(this._changeBuyAmountUseCase);

  @action
  Future<void> setSelected(BuyAmount control) async {
    try {
      await _changeBuyAmountUseCase(control);
      selected = control;
    } catch (e) {
      Logger.root.shout(e);
    }
  }
}
