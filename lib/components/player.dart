import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef<ClickerGame> {
  @override
  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(image: await gameRef.images.load("papaj.png"), srcSize: Vector2(1400 / 7, 230));
    final dance = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    animation = dance;
    height = (gameRef.size.x * 1.15) * 1.2;
    width = (gameRef.size.x) * 1.2;
    anchor = Anchor.bottomCenter;
    x = gameRef.size.x / 2;
    y = gameRef.size.y;
    super.onLoad();
  }
}
