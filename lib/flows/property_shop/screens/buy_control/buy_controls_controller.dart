import 'package:alpaka_clicker/flows/property_shop/domain/buy_amount.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'buy_controls_controller.g.dart';

@injectable
class BuyControlsController = BuyControlsControllerBase with _$BuyControlsController;

abstract class BuyControlsControllerBase with Store {
  @observable
  BuyAmount selected = BuyAmount.one;

  void setSelected(BuyAmount control) {
    selected = control;
  }
}
