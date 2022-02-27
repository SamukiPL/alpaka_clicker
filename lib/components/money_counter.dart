import 'package:alpaka_clicker/money/bank.dart';
import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MoneyCounter extends TextComponent with HasGameRef<ClickerGame> {
  late Bank bank = GetIt.instance.get<Bank>();

  @override
  Future<void>? onLoad() async {
    textRenderer = TextPaint(style: const TextStyle(color: Colors.amber));

    height = 50;
    x = gameRef.size.x / 2;
    y = 50;
    anchor = Anchor.center;

    super.onLoad();
  }

  double testX = 0;

  @override
  void update(double dt) {
    text = bank.getMoney().value.toString();
    super.update(dt);
  }
}