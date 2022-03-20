import 'package:alpaka_clicker/clicker_base/money/domain/pay_interest_use_case.dart';
import 'package:alpaka_clicker/clicker_base/money/domain/pay_salary_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClickerGameController {
  final PayInterestUseCase _payInterestUseCase;
  final PaySalaryUseCase _paySalaryUseCase;

  ClickerGameController(this._payInterestUseCase, this._paySalaryUseCase);

  void payInterest() {
    _payInterestUseCase();
  }

  void paySalary() {
    _paySalaryUseCase();
  }
}
