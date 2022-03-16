import 'package:alpaka_clicker/clicker_base/money/domain/buy/models/property_offer_model.dart';
import 'package:alpaka_clicker/util/monad/result.dart';

abstract class SpendMoneyRepository {
  Future<Result<bool>> buyProperty(PropertyOfferModel model);
}
