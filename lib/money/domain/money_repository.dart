import 'package:alpaka_clicker/util/monad/result.dart';

abstract class MoneyRepository {
  Future<void> payInterest();
  Future<void> paySalary();
  Stream<Result<String>> getDisplayableMoney();
}
