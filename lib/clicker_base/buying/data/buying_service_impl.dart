import 'package:alpaka_clicker/character_base/personalty/models/personalty_offer.dart';
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
    return Future(() {
      return _bank.spendMoney(offer.price, successReaction: () async {
        _bank.raiseInterest(offer.interest);
        await _propertiesService.increasePropertyCount(offer);
      });
    }).then((state) {
      if (state == SpendMoneyState.success) {
        return Result.success(BuyingState.bought);
      } else {
        return Result.success(BuyingState.notBought);
      }
    }).onError((Object error, stackTrace) {
      Logger.root.severe("BuyingServiceImpl", error);
      return (error is Exception) ? Result.failure(error) : throw error;
    });
  }

  @override
  Future<Result<BuyingState>> buyPersonalty(PersonaltyOffer offer) {
    // TODO: implement buyPersonalty
    throw UnimplementedError();
  }
}
