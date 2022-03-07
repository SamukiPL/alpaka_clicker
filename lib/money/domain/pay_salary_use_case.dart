import 'package:alpaka_clicker/money/domain/money_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaySalaryUseCase {
  final MoneyRepository _moneyRepository;

  PaySalaryUseCase(this._moneyRepository);

  Future<void> call() => _moneyRepository.paySalary();
}
