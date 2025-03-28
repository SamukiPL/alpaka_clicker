import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:alpaka_clicker/clicker_base/money/bank.dart';
import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:get_it/get_it.dart';

class BankInitializer extends Initializer {
  @override
  Future<void> call() async {
    final getIt = GetIt.instance;
    getIt.registerSingleton<Bank>(
        Bank(Currency(value: 0, power: 0), Currency(value: 1, power: 0), Currency(value: 0, power: 0)));
  }
}
