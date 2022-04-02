import 'package:alpaka_clicker/clicker_base/buying/domain/buying_service.dart';
import 'package:alpaka_clicker/clicker_base/buying/domain/buying_state.dart';
import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/spend_money_state.dart';
import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BuyingService)
class BuyingServiceImpl extends BuyingService {
  final Bank _bank;
  final PropertiesService _propertiesService;

  BuyingServiceImpl(this._bank, this._propertiesService);

  @override
  Future<Result<BuyingState>> buyProperty(PropertyOffer offer) async {
    try {
      if (_bank.spendMoney(offer.price) == SpendMoneyState.success) {
        _bank.raiseInterest(offer.interest);
        _propertiesService.increasePropertyCount(offer);
        return Result.success(BuyingState.bought);
      }
      return Result.success(BuyingState.notEnoughMoney);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
