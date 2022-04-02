import 'package:alpaka_clicker/clicker_base/buying/domain/buying_state.dart';
import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/util/monad/result.dart';

abstract class BuyingService {
  Future<Result<BuyingState>> buyProperty(PropertyOffer offer);
}
