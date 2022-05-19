import 'package:alpaka_clicker/clicker_base/buying/domain/buying_state.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:alpaka_clicker/flows/property_shop/screens/property_shop_controller.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../testUtils/mocked_models.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  const startingInterestPerSecond = "0,0/s";

  final getOffersUseCase = MockGetOffersUseCase();
  final buyPropertyUseCase = MockBuyPropertyUseCase();
  final interestPerSecondUseCase = MockGetDisplayableInterestPerSecondUseCase();
  setUpAll(() {
    resetMockitoState();
    when(interestPerSecondUseCase()).thenAnswer((realInvocation) => Future.value(Result.success("")));
  });

  test("PropertyShopController starts with empty list and start value for interest", () {
    final subject = PublishSubject<Result<List<PropertyModel>>>();
    when(getOffersUseCase()).thenAnswer((realInvocation) => subject.stream);

    final underTest = PropertyShopController(getOffersUseCase, buyPropertyUseCase, interestPerSecondUseCase);
    expect(underTest.models.isEmpty, true);
    expect(underTest.interestPerSecond, startingInterestPerSecond);
  });

  test("PropertyShopController can update interest per second observable by calling interestPerSecondUseCase returns success", () async {
    const displayableString = "Test";
    final interestPerSecondUseCase = MockGetDisplayableInterestPerSecondUseCase();
    final subject = BehaviorSubject<Result<List<PropertyModel>>>.seeded(Result.success(List.empty()));
    when(getOffersUseCase()).thenAnswer((realInvocation) => subject.stream);
    when(interestPerSecondUseCase()).thenAnswer((realInvocation) => Future.value(Result.success(displayableString)));

    final underTest = PropertyShopController(getOffersUseCase, buyPropertyUseCase, interestPerSecondUseCase);
    expect(underTest.interestPerSecond, startingInterestPerSecond);
    await underTest.updateInterestPerSecond();
    verify(interestPerSecondUseCase()).called(1);
    expect(underTest.interestPerSecond, displayableString);
  });

  test("PropertyShopController ignores failure when updating interest per second", () async {
    final interestPerSecondUseCase = MockGetDisplayableInterestPerSecondUseCase();
    final subject = BehaviorSubject<Result<List<PropertyModel>>>.seeded(Result.success(List.empty()));
    when(getOffersUseCase()).thenAnswer((realInvocation) => subject.stream);
    when(interestPerSecondUseCase()).thenAnswer((realInvocation) => Future.value(Result.failure(const FormatException())));

    final underTest = PropertyShopController(getOffersUseCase, buyPropertyUseCase, interestPerSecondUseCase);
    expect(underTest.interestPerSecond, startingInterestPerSecond);
    await underTest.updateInterestPerSecond();
    expect(underTest.interestPerSecond, startingInterestPerSecond);
  });

  test("PropertyShopController can buy properties", () async {
    final offer = emptyPropertyOffer();
    final buyPropertyUseCase = MockBuyPropertyUseCase();
    when(buyPropertyUseCase(any)).thenAnswer((realInvocation) => Future.value(Result.success(BuyingState.bought)));

    final underTest = PropertyShopController(getOffersUseCase, buyPropertyUseCase, interestPerSecondUseCase);
    await underTest.buyProperty(offer);
    verify(buyPropertyUseCase(offer)).called(1);
  });

  test("PropertyShopController subscribes to stream on initialization", () async {
    final getOffersUseCase = MockGetOffersUseCase();
    final subject = PublishSubject<Result<List<PropertyModel>>>();
    when(getOffersUseCase()).thenAnswer((realInvocation) => subject.stream);

    final underTest = PropertyShopController(getOffersUseCase, buyPropertyUseCase, interestPerSecondUseCase);
    await underTest.initializeController();
    verify(getOffersUseCase()).called(1);
  });

  test("PropertyShopController cancels stream subscription on dispose", () async {
    final getOffersUseCase = MockGetOffersUseCase();
    final interestPerSecondUseCase = MockGetDisplayableInterestPerSecondUseCase();
    final subject = PublishSubject<Result<List<PropertyModel>>>();
    when(getOffersUseCase()).thenAnswer((realInvocation) => subject.stream);

    final underTest = PropertyShopController(getOffersUseCase, buyPropertyUseCase, interestPerSecondUseCase);
    expect(underTest.models.isEmpty, true);
    await underTest.initializeController();
    await underTest.dispose();
    subject.add(Result.success([emptyPropertyModel()]));
    verifyNever(interestPerSecondUseCase());
    mobx.when((p0) => true, () {
      assert(false);
    });
  });

  test("PropertyShopController changes list every time subject emits", () async {
    final subject = PublishSubject<Result<List<PropertyModel>>>();
    when(getOffersUseCase()).thenAnswer((realInvocation) => subject.stream);

    final underTest = PropertyShopController(getOffersUseCase, buyPropertyUseCase, interestPerSecondUseCase);
    await underTest.initializeController();
    expect(underTest.models.isEmpty, true);
    subject.add(Result.success([emptyPropertyModel()]));
    mobx.when((p0) => true, () {
      expect(underTest.models.length, 1);
    });
  });

  test("PropertyShopController checks displayable interest every time subject emits", () async {
    const displayableString = "Test";
    final interestPerSecondUseCase = MockGetDisplayableInterestPerSecondUseCase();
    final subject = BehaviorSubject<Result<List<PropertyModel>>>.seeded(Result.success(List.empty()));
    when(getOffersUseCase()).thenAnswer((realInvocation) => subject.stream);
    when(interestPerSecondUseCase()).thenAnswer((realInvocation) => Future.value(Result.success(displayableString)));

    final underTest = PropertyShopController(getOffersUseCase, buyPropertyUseCase, interestPerSecondUseCase);
    await underTest.initializeController();
    verify(interestPerSecondUseCase()).called(1);
    mobx.when((p0) => true, () {
      expect(underTest.interestPerSecond, displayableString);
    });
  });
}
