import 'package:alpaka_clicker/clicker_base/money/currency.dart';
import 'package:alpaka_clicker/clicker_base/property/data/properties_service_impl.dart';
import 'package:alpaka_clicker/clicker_base/property/domain/properties_service.dart';
import 'package:alpaka_clicker/clicker_base/property/property.dart';
import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:get_it/get_it.dart';

class PropertiesInitializer extends Initializer {
  @override
  Future<void> call() async {
    final getIt = GetIt.instance;
    //TODO
    final tmpList = <Property>[
      Property(key: "turbo", name: "Guma Turbo", count: 0, baseIncrementation: Currency(value: 1.07, power: 0), basePrice: Currency(value: 1.5, power: 1), baseInterest: Currency(value: 0.0016, power: 0)),
      Property(key: "marysia", name: "Marysia", count: 0, baseIncrementation: Currency(value: 1.12, power: 0), basePrice: Currency(value: 1, power: 2), baseInterest: Currency(value: 1, power: 0))
    ];
    getIt.registerSingleton<PropertiesService>(PropertiesServiceImpl(tmpList));
  }
}
