import 'package:alpaka_clicker/flows/property_shop/domain/change_buy_amount_use_case.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../testUtils/expect_throw.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  setUpAll(() {
    resetMockitoState();
  });
  final propertiesRepository = MockPropertiesRepository();

  test("ChangeBuyAmountUseCase just runs with success", () async {
    when(propertiesRepository.changeBuyAmount(any)).thenAnswer((realInvocation) => Future<void>.value());
    final underTest = ChangeBuyAmountUseCase(propertiesRepository);
    await underTest(BuyAmount.one);
    expect(true, true);
  });

  test("ChangeBuyAmountUseCase throws FormatException", () async {
    when(propertiesRepository.changeBuyAmount(any)).thenThrow(const FormatException());
    final underTest = ChangeBuyAmountUseCase(propertiesRepository);
    expectAsyncThrow(() => underTest(BuyAmount.one), FormatException);
  });
}
