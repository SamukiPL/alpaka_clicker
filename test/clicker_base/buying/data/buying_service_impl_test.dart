import 'package:alpaka_clicker/clicker_base/buying/data/buying_service_impl.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_state.dart';
import 'package:alpaka_clicker/clicker_base/money/spend_money_state.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../testUtils/mocked_models.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  final propertiesService = MockPropertiesService();
  final propertyOffer = emptyPropertyOffer();
  setUp(() {
    resetMockitoState();
    when(propertiesService.increasePropertyCount(any)).thenAnswer((realInvocation) => Future.value());
  });

  test("BuyingService allows to buy property with PropertyOffer and return BuyingState.success", () async {
    final bank = MockBank();
    when(bank.spendMoney(any, successReaction: anyNamed("successReaction"))).thenAnswer((realInvocation) => Future.value(SpendMoneyState.success));
    final underTest = BuyingServiceImpl(bank, propertiesService);
    final returned = await underTest.buyProperty(propertyOffer);
    expect(returned.isSuccess(), true);
    expect((returned as Success).value, BuyingState.bought);
  });

  test("BuyingService allows to buy property with PropertyOffer and return BuyingState.notEnoughMoney", () async {
    final bank = MockBank();
    when(bank.spendMoney(any, successReaction: anyNamed("successReaction"))).thenAnswer((realInvocation) async {
      await realInvocation.namedArguments[const Symbol("successReaction")]();
      return Future.value(SpendMoneyState.priceIsTooBig);
    });
    final underTest = BuyingServiceImpl(bank, propertiesService);
    final returned = await underTest.buyProperty(propertyOffer);
    expect(returned.isSuccess(), true);
    expect((returned as Success).value, BuyingState.notBought);
  });

  test("Bank throws exception on spendMoney", () async {
    final bank = MockBank();
    when(bank.spendMoney(any, successReaction: anyNamed("successReaction"))).thenThrow(const FormatException());
    final underTest = BuyingServiceImpl(bank, propertiesService);
    final returned = await underTest.buyProperty(propertyOffer);
    expect(returned.isFailure(), true);
    expect((returned as Failure).error.runtimeType, FormatException);
  });

  test("Bank throws exception on raiseInterest", () async {
    final bank = MockBank();
    when(bank.spendMoney(any, successReaction: anyNamed("successReaction"))).thenAnswer((realInvocation) async {
      await realInvocation.namedArguments[const Symbol("successReaction")]();
      return Future.value(SpendMoneyState.success);
    });

    when(bank.raiseInterest(any)).thenThrow(const FormatException());
    final underTest = BuyingServiceImpl(bank, propertiesService);
    final returned = await underTest.buyProperty(propertyOffer);
    expect(returned.isFailure(), true);
    expect((returned as Failure).error.runtimeType, FormatException);
  });

  test("PropertiesService throws exception on increasePropertyCount", () async {
    final bank = MockBank();
    when(bank.spendMoney(any, successReaction: anyNamed("successReaction"))).thenAnswer((realInvocation) async {
      await realInvocation.namedArguments[const Symbol("successReaction")]();
      return Future.value(SpendMoneyState.success);
    });

    final propertiesService = MockPropertiesService();
    when(propertiesService.increasePropertyCount(any)).thenThrow(const FormatException());
    final underTest = BuyingServiceImpl(bank, propertiesService);
    final returned = await underTest.buyProperty(propertyOffer);
    expect(returned.isFailure(), true);
    expect((returned as Failure).error.runtimeType, FormatException);
  });
}
