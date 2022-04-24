import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:alpaka_clicker/screens/game/main_screen_toolbar.dart';
import 'package:alpaka_clicker/util/widgets/main_screen_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlpakaClickerWidget extends StatelessWidget {
  const AlpakaClickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainScreenToolbar(),
      body: Stack(
        children: [GameWidget(game: ClickerGame()), MainScreenMenu()],
      ),
    );
  }
}
