import 'package:alpaka_clicker/components/player.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class ClickerGame extends FlameGame with TapDetector, PanDetector {
  late Player player;

  @override
  Future<void> onLoad() async {
    player = Player();
    add(player);
  }

  @override
  void onTapUp(TapUpInfo info) {
    player.move(info.eventPosition.game);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.eventPosition.game);
  }
}
