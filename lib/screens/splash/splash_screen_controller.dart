import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:mobx/mobx.dart';

part 'splash_screen_controller.g.dart';

class SplashScreenController = _SplashScreenControllerBase with _$SplashScreenController;

abstract class _SplashScreenControllerBase with Store {
  @observable
  bool dependenciesLoaded = false;

  @action
  Future<void> loadDependencies() async {
    await initialize();
    dependenciesLoaded = true;
  }
}
