import 'package:alpaka_clicker/components/player.dart';
import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef<ClickerGame> {

  @override
  Future<void>? onLoad() async {
    sprite = Sprite(await gameRef.images.load("background.png"));
    width = gameRef.size.x;
    height = gameRef.size.y;
    add(Player());
    return super.onLoad();
  }
}