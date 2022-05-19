import 'package:alpaka_clicker/di/injector.dart';
import 'package:alpaka_clicker/initialize/bank_initializer.dart';
import 'package:alpaka_clicker/initialize/character_initializer.dart';
import 'package:alpaka_clicker/initialize/logger_initializer.dart';
import 'package:alpaka_clicker/initialize/properties_initializer.dart';
import 'package:alpaka_clicker/initialize/shared_prefs_initializer.dart';
import 'package:get_it/get_it.dart';

Future<void> initialize() async {
  for (var initializer in [
    SharedPrefsInitializer(),
    BankInitializer(),
    PropertiesInitializer(),
    CharacterInitializer(),
    LoggerInitializer()
  ]) {
    await initializer();
  }
  await configInjector(GetIt.instance);
}

abstract class Initializer {
  Future<void> call();
}
