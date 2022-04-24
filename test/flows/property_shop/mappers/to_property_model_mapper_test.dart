import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:alpaka_clicker/flows/property_shop/mappers/to_property_model_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../testUtils/mocked_models.dart';
import '../../../testUtils/mocks.mocks.dart';

void main() {
  final property = Property(key: "tag",
      name: "name",
      count: 0,
      baseIncrementation: emptyCurrency(),
      basePrice: currency(1, 0),
      baseInterest: emptyCurrency());

  const displayablePrice = "1";
  const displayableIncome = "1/s";

  final _beautifier = MockCurrencyBeautifier();
  setUp(() {
    resetMockitoState();
    when(_beautifier.beautifyCurrency(any)).thenReturn(displayablePrice);
    when(_beautifier.beautifyCurrencyPerSecond(any)).thenReturn(displayableIncome);
  });

  test("Mapper can be created with currencyBeautifier", () {
    final mapper = ToPropertyModelMapper(_beautifier);
    expect(mapper.runtimeType, ToPropertyModelMapper);
  });

  test("Mapper maps to property model that can't be bought", () {
    final money = emptyCurrency();
    final offer = property.getOffer();

    final mapper = ToPropertyModelMapper(_beautifier);
    final model = mapper(money, property, offer);
    expect(model.name, property.name);
    expect(model.propertyCount, property.count);
    expect(model.displayablePrice, displayablePrice);
    expect(model.displayableIncome, displayableIncome);
    expect(model.canBuy, false);
    expect(model.offer, offer);
  });

  test("Mapper maps to property model that can be bought", () {
    final offer = property.getOffer();
    final money = offer.price;

    final mapper = ToPropertyModelMapper(_beautifier);
    final model = mapper(money, property, offer);
    expect(model.name, property.name);
    expect(model.propertyCount, property.count);
    expect(model.displayablePrice, displayablePrice);
    expect(model.displayableIncome, displayableIncome);
    expect(model.canBuy, true);
    expect(model.offer, offer);
  });
}
