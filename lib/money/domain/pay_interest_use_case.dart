import 'package:alpaka_clicker/money/domain/money_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PayInterestUseCase {
  final MoneyRepository _moneyRepository;

  PayInterestUseCase(this._moneyRepository);

  Future<void> call() => _moneyRepository.payInterest();
}
