import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/buy/models/property_offer_model.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/buy/spend_money_repository.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:logging/logging.dart';

class SpendMoneyRepositoryImpl extends SpendMoneyRepository {
  final Bank _bank;

  SpendMoneyRepositoryImpl(this._bank);

  @override
  Future<Result<bool>> buyProperty(PropertyOfferModel model) async {
    try {
      _bank.spendMoney(model.price);
      _bank.raiseInterest(model.interest);
      return Success(true);
    } on Exception catch (e) {
      Logger.root.severe("SpendMoneyRepository", e);
      return Success(false);
    }
  }
}
