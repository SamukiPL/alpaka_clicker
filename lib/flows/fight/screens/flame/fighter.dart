import 'package:alpaka_clicker/flows/fight/screens/fight_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Fighter extends SpriteAnimationComponent with HasGameRef<FightGame> {
  @override
  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(image: await gameRef.images.load("papaj.png"), srcSize: Vector2(1400 / 7, 230));
    final dance = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    animation = dance;
    height = gameRef.size.y * 0.85;
    width = (gameRef.size.y * 0.85) * 1.15;
    anchor = Anchor.bottomLeft;
    x = 0;
    y = gameRef.size.y;
    super.onLoad();
  }
}
