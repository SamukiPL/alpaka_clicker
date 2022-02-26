import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:alpaka_clicker/money/bank.dart';
import 'package:alpaka_clicker/money/currency.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankInitializer extends Initializer {
  @override
  Future<void> call() async {
    final getIt = GetIt.instance;
    final sharedPrefs = getIt.get<SharedPreferences>();
    getIt.registerSingleton<Bank>(Bank(Currency(value: 0, power: 0), Currency(value: 0, power: 0), Currency(value: 0.016666, power: 0)));
  }
}