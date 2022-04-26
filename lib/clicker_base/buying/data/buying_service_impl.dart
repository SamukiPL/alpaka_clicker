import 'package:alpaka_clicker/clicker_base/buying/domain/buying_service.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_state.dart';
import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/spend_money_state.dart';
import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@Singleton(as: BuyingService)
class BuyingServiceImpl extends BuyingService {
  final Bank _bank;
  final PropertiesService _propertiesService;

  BuyingServiceImpl(this._bank, this._propertiesService);

  @override
  Future<Result<BuyingState>> buyProperty(PropertyOffer offer) async {
    try {
      final buyingState = await _bank.spendMoney(offer.price, reaction: (state) async {
        _bank.raiseInterest(offer.interest);
        await _propertiesService.increasePropertyCount(offer);
      }).then((state) {
        if (state == SpendMoneyState.success) {
          BuyingState.bought;
        } else {
          BuyingState.notBought;
        }
      });
      return Result.success(buyingState);
    } on Exception catch (e) {
      Logger.root.severe("BuyingServiceImpl", e);
      return Result.failure(e);
    }
  }
}
