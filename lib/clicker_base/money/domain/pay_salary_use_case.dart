import 'package:alpaka_clicker/clicker_base/money/domain/money_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaySalaryUseCase {
  final MoneyService _moneyRepository;

  PaySalaryUseCase(this._moneyRepository);

  Future<void> call() => _moneyRepository.paySalary();
}
