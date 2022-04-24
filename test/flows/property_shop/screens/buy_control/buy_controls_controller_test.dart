import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:alpaka_clicker/flows/property_shop/screens/buy_control/buy_controls_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../testUtils/mocks.mocks.dart';

void main() {
  final changeBuyAmountUseCase = MockChangeBuyAmountUseCase();
  setUp(() {
    resetMockitoState();
    when(changeBuyAmountUseCase(any)).thenAnswer((realInvocation) => Future.value());
  });

  test("Controller starts with BuyAmount.one", () {
    final underTest = BuyControlsController(changeBuyAmountUseCase);
    expect(underTest.selected, BuyAmount.one);
  });

  test("Controller can change its selected value", () async {
    const newSelected = BuyAmount.ten;
    final underTest = BuyControlsController(changeBuyAmountUseCase);
    await underTest.setSelected(newSelected);
    verify(changeBuyAmountUseCase(newSelected)).called(1);
    expect(underTest.selected, newSelected);
  });
}
