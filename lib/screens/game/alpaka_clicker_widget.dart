import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlpakaClickerWidget extends StatelessWidget {
  const AlpakaClickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GameWidget(game: ClickerGame());
      }
    );
  }
}
