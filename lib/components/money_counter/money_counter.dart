import 'package:alpaka_clicker/components/money_counter/money_symbol.dart';
import 'package:alpaka_clicker/components/money_counter/money_text.dart';
import 'package:alpaka_clicker/money/bank.dart';
import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MoneyCounter extends SpriteComponent with HasGameRef<ClickerGame> {

  @override
  Future<void>? onLoad() async {
    sprite = Sprite(await gameRef.images.load("money_background.png"));

    width = 150;
    height = 50;
    x = 15;
    y = 35;

    add(MoneyText());
    add(MoneySymbol());
    super.onLoad();
  }
}