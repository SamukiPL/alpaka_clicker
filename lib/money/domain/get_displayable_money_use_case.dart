import 'package:alpaka_clicker/money/domain/money_repository.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDisplayableMoneyUseCase {
  final MoneyRepository _moneyRepository;

  GetDisplayableMoneyUseCase(this._moneyRepository);

  Stream<Result<String>> call() => _moneyRepository.getDisplayableMoney();
}
