
import 'package:alpaka_clicker/clicker_game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Player extends SpriteAnimationComponent with HasGameRef<ClickerGame> {
  late Vector2 clickedPosition = Vector2(gameRef.size.x / 2, gameRef.size.y / 2);

  @override
  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(image: await gameRef.images.load("papaj.png"), srcSize: Vector2(1400/7, 230));
    final dance = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    animation = dance;
    height = gameRef.size.x;
    width = gameRef.size.x;
    anchor = Anchor.center;
    position = clickedPosition;
  }

  @override
  void update(double dt) {
    y += (y > clickedPosition.y.floor())? -1.0 : 1.0;
    x += (x > clickedPosition.x.floor())? -1.0 : 1.0;

    super.update(dt);
  }

  void move(Vector2 delta) {
    clickedPosition = delta;
  }
}