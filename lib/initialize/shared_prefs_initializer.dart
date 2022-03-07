import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsInitializer extends Initializer {
  @override
  Future<void> call() async {
    final prefs = await SharedPreferences.getInstance();
    GetIt.instance.registerSingleton<SharedPreferences>(prefs);
  }
}
