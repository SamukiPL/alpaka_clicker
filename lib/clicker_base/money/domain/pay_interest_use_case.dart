import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class PayInterestUseCase {
  final MoneyService _moneyRepository;

  PayInterestUseCase(this._moneyRepository);

  Future<void> call() => _moneyRepository.payInterest();
}
