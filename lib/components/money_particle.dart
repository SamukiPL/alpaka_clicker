import 'dart:math';

import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:flame/components.dart';

class MoneyParticle extends SpriteComponent with HasGameRef<ClickerGame> {
  final Vector2 startPosition;

  MoneyParticle(this.startPosition);

  @override
  Future<void>? onLoad() async {
    sprite = Sprite(await gameRef.images.load("putin.png"));
    height = 25;
    width = 25;
    position = startPosition;
    anchor = Anchor.center;
    super.onLoad();
  }

  double testX = 0;

  @override
  void update(double dt) {
    final testV = test();
    if (position.y > gameRef.size.y) {
      removeFromParent();
    }

    position.add(testV);
    testX += dt;
    super.update(dt);
  }

  Vector2 test() {
    return Vector2(testX, (pow(testX, 2).roundToDouble()) + (4 * testX));
  }
}