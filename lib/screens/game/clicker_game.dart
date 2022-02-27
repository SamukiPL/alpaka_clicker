import 'package:alpaka_clicker/components/background.dart';
import 'package:alpaka_clicker/components/money_particle.dart';
import 'package:alpaka_clicker/screens/game/clicker_game_controller.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:get_it/get_it.dart';

class ClickerGame extends FlameGame with TapDetector, PanDetector {
  final _getIt = GetIt.instance;
  late final ClickerGameController _gameController = _getIt.get<ClickerGameController>();

  ClickerGame();

  @override
  Future<void> onLoad() async {
    add(Background());
    super.onLoad();
  }

  @override
  void update(double dt) {
    _gameController.payInterest();
    super.update(dt);
  }

  @override
  void onTapUp(TapUpInfo info) {
    _gameController.paySalary();
    add(MoneyParticle(info.eventPosition.game));
  }
}
