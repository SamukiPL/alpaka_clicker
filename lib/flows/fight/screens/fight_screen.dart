import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:alpaka_clicker/flows/fight/domain/models/log_model.dart';
import 'package:alpaka_clicker/flows/fight/screens/fight_game.dart';
import 'package:alpaka_clicker/flows/fight/screens/fight_log/fight_log_widget.dart';
import 'package:alpaka_clicker/flows/fight/screens/fight_screen_controller.dart';
import 'package:alpaka_clicker/flows/fight/screens/health/health_bar.dart';
import 'package:alpaka_clicker/util/widgets/disposable_widget.dart';
import 'package:alpaka_clicker/util/widgets/money_counters/money_counter_toolbar.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class FightScreen extends StatelessWidget {
  final FightScreenController _controller = GetIt.instance.get<FightScreenController>();

  FightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listKey = GlobalKey<AnimatedListState>();
    final disposer = reaction<List<LogModel>>((reaction) => _controller.logs, (value) {
      listKey.currentState?.insertItem(0);
    });
    return DisposableWidget(
      dispose: () {
        disposer.reaction.dispose();
        _controller.dispose();
      },
      child: Scaffold(
        appBar: MoneyCounterToolbar(),
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 21 / 9,
              child: GameWidget(game: FightGame()),
            ),
            const Divider(thickness: 2, height: 2, color: BaseColors.primary),
            Observer(builder: (_) => HealthBar(playerHealth: _controller.playerHealth, enemyHealth: _controller.enemyHealth)),
            const Divider(thickness: 2, height: 2, color: BaseColors.primary),
            Expanded(
              child: Observer(builder: (_) => FightLogWidget(listKey: listKey, logs: _controller.logs)),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey.shade400,
              height: 90,
              child: const Text("Banner"),
            )
          ],
        ),
      ),
    );
  }
}
