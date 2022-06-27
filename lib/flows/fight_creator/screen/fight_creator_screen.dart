import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:alpaka_clicker/flows/fight_creator/screen/difficulty/difficulty_chooser.dart';
import 'package:alpaka_clicker/flows/fight_creator/screen/difficulty/difficulty_explanation.dart';
import 'package:alpaka_clicker/flows/fight_creator/screen/fight_creator_controller.dart';
import 'package:alpaka_clicker/flows/fight_creator/screen/fight_creator_navigation.dart';
import 'package:alpaka_clicker/util/widgets/buttons/clicker_button.dart';
import 'package:alpaka_clicker/util/widgets/disposable_widget.dart';
import 'package:alpaka_clicker/util/widgets/loading_widget.dart';
import 'package:alpaka_clicker/util/widgets/money_counters/money_counter_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class FightCreatorScreen extends StatelessWidget {
  final FightCreatorController _controller = GetIt.instance.get();
  final FightCreatorNavigation _navigation = GetIt.instance.get();

  FightCreatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisposableWidget(
        initialize: () {
          _controller.initializeController();
        },
        child: Scaffold(
          appBar: MoneyCounterToolbar(),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Observer(
              builder: (_) => (_controller.isLoading) ? const LoadingWidget() : _buildCreatorScreen(),
            ),
          ),
        ),
        dispose: () {
          _controller.dispose();
        });
  }

  Widget _buildCreatorScreen() {
    final difficultyModel = _controller.difficultyModel!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DifficultyChooser(
          currentChosen: difficultyModel.type,
          onChosen: (type) => _controller.changeDifficulty(type),
        ),
        Expanded(
          child: DifficultyExplanation(
            model: difficultyModel,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Builder(
            builder: (context) {
              return ClickerButton(
                onTap: () {
                  _navigation.goToFightScreen(context, difficultyModel);
                },
                color: BaseColors.primary,
                child: const Text(
                  "Trenuj",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}
