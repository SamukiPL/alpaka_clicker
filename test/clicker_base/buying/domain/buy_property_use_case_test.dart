import 'package:alpaka_clicker/clicker_base/buying/domain/buy_property_use_case.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_state.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../testUtils/expect_throw.dart';
import '../../../testUtils/mocked_models.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  setUpAll(() {
    resetMockitoState();
  });
  final buyingService = MockBuyingService();
  final offer = emptyPropertyOffer();

  test("BuyingService return Success with BuyingState.bought", () async {
    when(buyingService.buyProperty(any)).thenAnswer((_) async => Result.success(BuyingState.bought));
    final underTest = BuyPropertyUseCase(buyingService);
    final returned = await underTest(offer);
    expect(returned.isSuccess(), true);
    expect((returned as Success).value, BuyingState.bought);
  });

  test("BuyingService return Success with BuyingState.notEnoughMoney", () async {
    when(buyingService.buyProperty(any)).thenAnswer((_) async => Result.success(BuyingState.notBought));
    final underTest = BuyPropertyUseCase(buyingService);
    final returned = await underTest(offer);
    expect(returned.isSuccess(), true);
    expect((returned as Success).value, BuyingState.notBought);
  });

  test("MoneyRepository return Stream and emits Failure with FormatException", () async {
    when(buyingService.buyProperty(any)).thenAnswer((_) async => Result.failure(const FormatException()));
    final underTest = BuyPropertyUseCase(buyingService);
    final returned = await underTest(offer);
    expect(returned.isFailure(), true);
    expect((returned as Failure).error.runtimeType, FormatException);
  });

  test("MoneyRepository throws Exception", () async {
    when(buyingService.buyProperty(any)).thenAnswer((_) => throw const FormatException());
    final underTest = BuyPropertyUseCase(buyingService);
    expectAsyncThrow(() => underTest(offer), FormatException);
  });
}
