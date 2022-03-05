import 'package:alpaka_clicker/util/monad/result.dart';

abstract class MoneyRepository {
  Result<String> getDisplayableMoney();
}
