
import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef<ClickerGame> {

  @override
  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(image: await gameRef.images.load("papaj.png"), srcSize: Vector2(1400/7, 230));
    final dance = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    animation = dance;
    height = gameRef.size.x;
    width = gameRef.size.x;
    anchor = Anchor.bottomCenter;
    x = gameRef.size.x / 2;
    y = gameRef.size.y - 70;
    super.onLoad();
  }
}