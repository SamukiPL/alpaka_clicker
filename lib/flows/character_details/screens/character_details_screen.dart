import 'package:alpaka_clicker/base/base_times.dart';
import 'package:alpaka_clicker/flows/character_details/screens/character_details_controller.dart';
import 'package:alpaka_clicker/flows/character_details/screens/character_info/character_info_widget.dart';
import 'package:alpaka_clicker/flows/character_details/screens/character_info/quick_attributes_widget.dart';
import 'package:alpaka_clicker/flows/character_details/screens/list/personalty_view_holder.dart';
import 'package:alpaka_clicker/util/widgets/disposable_widget.dart';
import 'package:alpaka_clicker/util/widgets/loading_widget.dart';
import 'package:alpaka_clicker/util/widgets/money_counters/money_counter_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class CharacterDetailsScreen extends StatelessWidget {
  late final CharacterDetailsController _controller = GetIt.instance.get<CharacterDetailsController>();

  CharacterDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisposableWidget(
      initialize: () {
        _controller.initialize();
      },
      child: Scaffold(
        appBar: MoneyCounterToolbar(),
        body: Observer(
          builder: (_) =>
              AnimatedSwitcher(
                duration: BaseTimes.baseTransitionDuration,
                child: decideOnCurrentScreen(),
              ),
        ),
      ),
      dispose: () {
        _controller.dispose();
      },
    );
  }

  Widget decideOnCurrentScreen() {
    if (_controller.isLoading) {
      return const LoadingWidget();
    } else {
      return buildLoadedScreen();
    }
  }

  Widget buildLoadedScreen() {
    final characterModel = _controller.characterInfoModel!;
    return ListView(
      children: [
        CharacterInfoWidget(infoModel: characterModel),
        QuickAttributesWidget(canDistributePoints: characterModel.canDistributePoints,
          attributes: characterModel.attributes,
          distributePoint: (attribute) => _controller.levelUpAttribute(attribute),),
        Expanded(child: buildPersonaltiesList()),
      ],
    );
  }

  Widget buildPersonaltiesList() {
    return Observer(
      builder: (_) =>
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, index) =>
            const Divider(
              color: Color(0xFFD5A800),
              thickness: 0.8,
            ),
            itemCount: _controller.personalties.length,
            itemBuilder: (context, index) {
              final personalty = _controller.personalties[index];
              return PersonaltyViewHolder(
                model: personalty,
                onBuy: () => _controller.buyPersonalty(personalty.offer),
              );
            },
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
          ),
    );
  }
}
