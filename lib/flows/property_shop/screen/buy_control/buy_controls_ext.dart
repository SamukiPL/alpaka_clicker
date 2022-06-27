import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';

extension BuyControlsExt on BuyAmount {
  String getControlString() {
    switch (this) {
      case BuyAmount.one:
        return "+1";
      case BuyAmount.ten:
        return "+10";
      case BuyAmount.hundred:
        return "+100";
      default:
        throw ArgumentError("There is no more controls");
    }
  }
}
