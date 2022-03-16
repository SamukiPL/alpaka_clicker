import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDisplayableMoneyUseCase {
  final MoneyService _moneyRepository;

  GetDisplayableMoneyUseCase(this._moneyRepository);

  Stream<Result<String>> call() => _moneyRepository.getDisplayableMoney();
}
