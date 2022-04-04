import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:alpaka_clicker/util/monad/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDisplayableInterestPerSecondUseCase {
  final MoneyService _moneyRepository;

  GetDisplayableInterestPerSecondUseCase(this._moneyRepository);

  Future<Result<String>> call() => _moneyRepository.getDisplayableInterestPerSecond();
}
