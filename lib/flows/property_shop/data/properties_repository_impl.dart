import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/money/currency_beautifier.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:alpaka_clicker/flows/property_shop/data/store_clerc.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/property_model.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/properties_repository.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:alpaka_clicker/util/pair.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: PropertiesRepository)
class PropertiesRepositoryImpl implements PropertiesRepository {
  final MoneyService _moneyService;
  final PropertiesService _propertiesService;
  final StoreClerc _storeClerc;
  final CurrencyBeautifier _beautifier;

  PropertiesRepositoryImpl(this._moneyService, this._propertiesService, this._storeClerc, this._beautifier);

  BuyAmount _currentAmount = BuyAmount.one;
  bool _refreshOffers = true;

  @override
  Stream<Result<List<PropertyModel>>> getPropertiesList() {
    return CombineLatestStream.combine2(
      _moneyService.getDepositedMoney(),
      _propertiesService.listenToProperties().doOnEach((notification) {_refreshOffers = true;}),
      (Currency a, List<Property> b) => Pair(a, b),
    )
        .distinct(
      (previous, next) => !(_storeClerc.canAffordNewItem(next.first) || _refreshOffers),
    )
        .doOnData((pair) {
      _refreshOffers = false;
    }).map((pair) {
      final buyAmount = getBuyCount();
      final money = pair.first;
      final properties = pair.last;

      final propertiesWithOffers = properties.asMap().map(
            (index, property) => MapEntry(property, property.getOffer(offerCount: buyAmount)),
          );
      _storeClerc.updateCurrentOffers(propertiesWithOffers.values, money);

      final models = propertiesWithOffers
          .map((property, offer) => MapEntry(
              property,
              PropertyModel(
                name: "TODO Name",
                count: properties.firstWhere((element) => element.key == offer.key).count,
                displayableIncome: _beautifier.beautifyInterestPerSecond(property.baseInterest),
                displayablePrice: _beautifier.beautifyCurrency(offer.price),
                offer: offer,
                canBuy: offer.canBeBought(money),
              )))
          .values
          .toList();
      return Result.success(models);
    }).onErrorReturnWith((error, stackTrace) => (error is Exception) ? Result.failure(error) : throw error);
  }

  @override
  Future<void> changeBuyAmount(BuyAmount amount) async {
    _refreshOffers = true;
    _currentAmount = amount;
  }

  int getBuyCount() {
    switch (_currentAmount) {
      case BuyAmount.one:
        return 1;
      case BuyAmount.ten:
        return 10;
      case BuyAmount.hundred:
        return 100;
    }
  }
}
