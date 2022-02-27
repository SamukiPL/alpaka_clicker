import 'package:alpaka_clicker/screens/game/clicker_game.dart';
import 'package:alpaka_clicker/screens/game/game_navigation.dart';
import 'package:alpaka_clicker/util/widgets/navigation_bar/navigation_bar_widget.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AlpakaClickerWidget extends StatelessWidget {
  const AlpakaClickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigation = GetIt.instance.get<GameNavigation>();
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: ClickerGame()),
          Positioned(
            bottom: 0,
            left: 0,
            child: NavigationBarWidget(listener: navigation,)
          )
        ],
      ),
    );
  }
}
