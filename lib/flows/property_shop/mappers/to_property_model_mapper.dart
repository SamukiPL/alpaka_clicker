import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/currency_beautifier.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ToPropertyModelMapper {
  final CurrencyBeautifier _beautifier;

  ToPropertyModelMapper(this._beautifier);

  PropertyModel call(Currency currentMoney, Property property, PropertyOffer offer) => PropertyModel(
      name: property.name,
      displayablePrice: _beautifier.beautifyCurrency(offer.price),
      displayableIncome: _beautifier.beautifyCurrencyPerSecond(property.baseInterest),
      propertyCount: property.count,
      offer: offer,
      canBuy: offer.canBeBought(currentMoney));
}
