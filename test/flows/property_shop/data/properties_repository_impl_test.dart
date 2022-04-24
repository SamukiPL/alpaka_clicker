import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:alpaka_clicker/flows/property_shop/data/properties_repository_impl.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../testUtils/mocked_models.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  final _cheapest = currency(1, 1);
  final _mostExpensive = currency(1, 100);
  final _properties = List<Property>.of([
    Property(
        key: "tmp",
        name: "name",
        count: 0,
        baseIncrementation: currency(1.07, 0),
        basePrice: _cheapest,
        baseInterest: emptyCurrency()),
    Property(
        key: "tmp1",
        name: "name1",
        count: 0,
        baseIncrementation: currency(1.11, 0),
        basePrice: _mostExpensive,
        baseInterest: emptyCurrency()),
  ]);

  final _moneyService = MockMoneyService();
  final _propertiesService = MockPropertiesService();
  final _storeClerc = MockStoreClerc();
  final _toPropertyModelMapper = MockToPropertyModelMapper();
  setUp(() {
    resetMockitoState();
  });

  test("BuyAmount can be changed", () {
    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.changeBuyAmount(BuyAmount.hundred);
  });

  test("Repository starts with BuyAmount.one", () {
    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    expect(underTest.getBuyCount(), 1);
  });

  test("Returns int for current BuyAmount", () {
    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.changeBuyAmount(BuyAmount.hundred);
    expect(underTest.getBuyCount(), 100);
  });

  test("Never distinct first event and storeClerc gets its offers updated", () async {
    final currencySubject = PublishSubject<Currency>();
    final propertiesSubject = PublishSubject<List<Property>>();
    when(_moneyService.getDepositedMoney()).thenAnswer((_) => currencySubject.stream);
    when(_propertiesService.listenToProperties()).thenAnswer((_) => propertiesSubject.stream);
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(emptyPropertyModel());

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {
      verify(_storeClerc.updateCurrentOffers(any, any));
      }, max: 1));
    currencySubject.add(emptyCurrency());
    propertiesSubject.add([]);
  });

  test("Never distinct when you can buy new items", () async {
    final currencySubject = PublishSubject<Currency>();
    final propertiesSubject = PublishSubject<List<Property>>();
    when(_moneyService.getDepositedMoney()).thenAnswer((_) => currencySubject.stream);
    when(_propertiesService.listenToProperties()).thenAnswer((_) => propertiesSubject.stream);
    when(_storeClerc.canAffordNewItem(any)).thenReturn(true);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(emptyPropertyModel());

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {}, max: 2));
    currencySubject.add(emptyCurrency());
    propertiesSubject.add([]);
    currencySubject.add(emptyCurrency());
  });

  test("Distinct events when you cant buy and there is no refresh needed", () async {
    final currencySubject = PublishSubject<Currency>();
    final propertiesSubject = PublishSubject<List<Property>>();
    when(_moneyService.getDepositedMoney()).thenAnswer((_) => currencySubject.stream);
    when(_propertiesService.listenToProperties()).thenAnswer((_) => propertiesSubject.stream);
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(emptyPropertyModel());

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {}, max: 1));
    currencySubject.add(emptyCurrency());
    propertiesSubject.add([]);
    currencySubject.add(emptyCurrency());
  });

  test("Changing buy amount will cause to not distinct next event", () async {
    final currencySubject = PublishSubject<Currency>();
    final propertiesSubject = PublishSubject<List<Property>>();
    when(_moneyService.getDepositedMoney()).thenAnswer((_) => currencySubject.stream);
    when(_propertiesService.listenToProperties()).thenAnswer((_) => propertiesSubject.stream);
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(emptyPropertyModel());

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {}, max: 2));
    currencySubject.add(emptyCurrency());
    propertiesSubject.add([]);
    currencySubject.add(emptyCurrency());
    underTest.changeBuyAmount(BuyAmount.ten);
    propertiesSubject.add([]);
    currencySubject.add(emptyCurrency());
  });

  test("Changing buy amount will cause to not distinct next event", () async {
    final currencySubject = PublishSubject<Currency>();
    final propertiesSubject = PublishSubject<List<Property>>();
    when(_moneyService.getDepositedMoney()).thenAnswer((_) => currencySubject.stream);
    when(_propertiesService.listenToProperties()).thenAnswer((_) => propertiesSubject.stream);
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(emptyPropertyModel());

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {}, max: 2));
    currencySubject.add(emptyCurrency());
    propertiesSubject.add([]);
    currencySubject.add(emptyCurrency());
    underTest.changeBuyAmount(BuyAmount.ten);
    propertiesSubject.add([]);
    currencySubject.add(emptyCurrency());
  });

  test("Returns list of PropertyModels that can't be bought", () async {
    when(_moneyService.getDepositedMoney()).thenAnswer((_) async* {
      yield emptyCurrency();
    });
    when(_propertiesService.listenToProperties()).thenAnswer((_) async* {
      yield _properties;
    });
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(emptyPropertyModel());

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {
      expect(event.isSuccess(), true);
      event.onSuccess((value) {
        expect(value.length, _properties.length);
        expect(value.runtimeType, List<PropertyModel>);
      });
    }, max: 1));
  });

  test("Returns list of PropertyModels that only one can be bought using money from service", () async {
    when(_moneyService.getDepositedMoney()).thenAnswer((_) async* {
      yield _cheapest;
    });
    when(_propertiesService.listenToProperties()).thenAnswer((_) async* {
      yield _properties;
    });
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, _properties[0], any)).thenReturn(propertyModel(canBuy: true));

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {
      expect(event.isSuccess(), true);
      event.onSuccess((value) {
        expect(value.length, _properties.length);
        expect(value.runtimeType, List<PropertyModel>);
        expect(value.where((element) => element.canBuy).length, 1);
      });
    }, max: 1));
  });

  test("Returns list of PropertyModels that all can be bought using money from service", () async {
    when(_moneyService.getDepositedMoney()).thenAnswer((_) async* {
      yield _mostExpensive;
    });
    when(_propertiesService.listenToProperties()).thenAnswer((_) async* {
      yield _properties;
    });
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(propertyModel(canBuy: true));

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {
      expect(event.isSuccess(), true);
      event.onSuccess((value) {
        expect(value.length, _properties.length);
        expect(value.runtimeType, List<PropertyModel>);
        expect(value.where((element) => element.canBuy).length, _properties.length);
      });
    }, max: 1));
  });

  test("Returns list again when buyAmount was changed", () async {
    when(_moneyService.getDepositedMoney()).thenAnswer((_) async* {
      yield emptyCurrency();
    });
    when(_propertiesService.listenToProperties()).thenAnswer((_) async* {
      yield _properties;
    });
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(emptyPropertyModel());

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.getPropertiesList().listen(expectAsync1((event) {
      expect(event.isSuccess(), true);
      event.onSuccess((value) {
        expect(value.length, _properties.length);
        expect(value.runtimeType, List<PropertyModel>);
      });
    }, max: 2));
    underTest.changeBuyAmount(BuyAmount.ten);
  });

  test("Returns list with offers that has count 10 for BuyAmount.ten", () async {
    const offerCount = 10;
    final offer = _properties.first.getOffer(offerCount: offerCount);
    when(_moneyService.getDepositedMoney()).thenAnswer((_) async* {
      yield emptyCurrency();
    });
    when(_propertiesService.listenToProperties()).thenAnswer((_) async* {
      yield _properties;
    });
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(propertyModel(offer: offer));

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.changeBuyAmount(BuyAmount.ten);
    underTest.getPropertiesList().listen(expectAsync1((event) {
      expect(event.isSuccess(), true);
      event.onSuccess((value) {
        expect(value.length, _properties.length);
        expect(value.runtimeType, List<PropertyModel>);
        expect(value.first.offer.count, 10);
        expect(value.firstWhere((element) => element.offer.key == offer.key).canBuy, false);
      });
    }, max: 1));
  });

  test("Returns list with offers that has count 100 for BuyAmount.hundred", () async {
    const offerCount = 100;
    final offer = _properties.first.getOffer(offerCount: offerCount);
    when(_moneyService.getDepositedMoney()).thenAnswer((_) async* {
      yield emptyCurrency();
    });
    when(_propertiesService.listenToProperties()).thenAnswer((_) async* {
      yield _properties;
    });
    when(_storeClerc.canAffordNewItem(any)).thenReturn(false);
    when(_toPropertyModelMapper(any, any, any)).thenReturn(propertyModel(offer: offer));

    final underTest = PropertiesRepositoryImpl(_moneyService, _propertiesService, _storeClerc, _toPropertyModelMapper);
    underTest.changeBuyAmount(BuyAmount.hundred);
    underTest.getPropertiesList().listen(expectAsync1((event) {
      expect(event.isSuccess(), true);
      event.onSuccess((value) {
        expect(value.length, _properties.length);
        expect(value.runtimeType, List<PropertyModel>);
        expect(value.first.offer.count, offerCount);
        expect(value.firstWhere((element) => element.offer.key == offer.key).canBuy, false);
      });
    }, max: 1));
  });
}
