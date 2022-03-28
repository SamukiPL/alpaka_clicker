import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/util/monad/result.dart';

abstract class MoneyService {
  Future<void> payInterest();

  Future<void> paySalary();

  Stream<Currency> getDepositedMoney();
  Stream<Result<String>> getDisplayableMoney();
}
