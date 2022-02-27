import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:mobx/mobx.dart';

part 'splash_screen_controller.g.dart';

class SplashScreenController = SplashScreenControllerBase with _$SplashScreenController;

abstract class SplashScreenControllerBase with Store {
  @observable
  bool dependenciesLoaded = false;

  @action
  Future<void> loadDependencies() async {
    await initialize();
    dependenciesLoaded = true;
  }
}