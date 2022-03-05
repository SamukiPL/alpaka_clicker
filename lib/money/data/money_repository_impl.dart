import 'package:alpaka_clicker/money/bank.dart';
import 'package:alpaka_clicker/money/currency_beautifier.dart';
import 'package:alpaka_clicker/money/domain/money_repository.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MoneyRepository)
class MoneyRepositoryImpl implements MoneyRepository {
  final Bank _bank;
  final CurrencyBeautifier _beautifier;

  MoneyRepositoryImpl(this._bank, this._beautifier);

  @override
  Result<String> getDisplayableMoney() {
    try {
      return Success(_beautifier.beautifyCurrency(_bank.getMoney()));
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
