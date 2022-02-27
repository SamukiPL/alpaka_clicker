import 'package:alpaka_clicker/money/bank.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClickerGameController {
  final Bank _bank;

  ClickerGameController(this._bank);

  void payInterest() {
    _bank.payInterest();
  }

  void paySalary() {
    _bank.paySalary();
  }
}