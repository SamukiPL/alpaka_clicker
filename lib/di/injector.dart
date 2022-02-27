import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:alpaka_clicker/di/injector.config.dart';

@InjectableInit(
  asExtension: true,
  initializerName: 'init',
  usesNullSafety: true
)
configInjector(GetIt getIt) {
  return getIt.init();
}