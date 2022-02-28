import 'package:alpaka_clicker/money/bank.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MoneyText extends TextComponent {
  late Bank bank = GetIt.instance.get<Bank>();

  @override
  Future<void>? onLoad() async {
    textRenderer =
        TextPaint(style: const TextStyle(color: Colors.amber, fontSize: 25));

    height = 150;
    x = 100;
    y = 25;
    anchor = Anchor.centerRight;

    super.onLoad();
  }

  @override
  void update(double dt) {
    text = bank.getMoney().value.toStringAsPrecision(3);
    super.update(dt);
  }
}
