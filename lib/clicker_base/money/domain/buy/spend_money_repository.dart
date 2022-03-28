import 'package:alpaka_clicker/clicker_base/property/models/property_offer.dart';
import 'package:alpaka_clicker/util/monad/result.dart';

abstract class SpendMoneyRepository {
  Future<Result<bool>> buyProperty(PropertyOffer model);
}
