import 'package:alpaka_clicker/di/injector.dart';
import 'package:alpaka_clicker/initialize/bank_initializer.dart';
import 'package:get_it/get_it.dart';

Future<void> initialize() async {
  await configInjector(GetIt.instance);
 for (var initializer in [
   BankInitializer()
 ]) {
   await initializer();
 }
}

abstract class Initializer {
  Future<void> call();
}