import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:alpaka_clicker/flows/property_shop/screens/buy_control/buy_controls_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("BuyAmount.one returns +1", () {
    const underTest = BuyAmount.one;
    expect(underTest.getControlString(), "+1");
  });

  test("BuyAmount.ten returns +10", () {
    const underTest = BuyAmount.ten;
    expect(underTest.getControlString(), "+10");
  });

  test("BuyAmount.hundred returns +100", () {
    const underTest = BuyAmount.hundred;
    expect(underTest.getControlString(), "+100");
  });
}
