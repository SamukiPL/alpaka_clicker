import 'package:alpaka_clicker/flows/property_shop/screen/buy_control/buy_controls_widget.dart';
import 'package:alpaka_clicker/flows/property_shop/screen/list/property_view_holder.dart';
import 'package:alpaka_clicker/flows/property_shop/screen/property_shop_controller.dart';
import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:alpaka_clicker/theme/text_styles.dart';
import 'package:alpaka_clicker/util/widgets/disposable_widget.dart';
import 'package:alpaka_clicker/util/widgets/money_counters/money_counter_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:text_scroll/text_scroll.dart';

class PropertyShopScreen extends StatelessWidget {
  final PropertyShopController _controller = GetIt.instance.get<PropertyShopController>();

  PropertyShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisposableWidget(
      initialize: () => _controller.initializeController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MoneyCounterToolbar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 1,
                  child: _buildCurrentPerSecond(),
                ),
                Flexible(
                  flex: 1,
                  child: BuyControlsWidget(),
                )
              ],
            ),
            Expanded(
              child: _buildPropertiesList(),
            )
          ],
        ),
      ),
      dispose: () {
        _controller.dispose();
      },
    );
  }

  Widget _buildCurrentPerSecond() => Observer(
    builder: (_) => Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
          decoration: defaultDecoration(),
          alignment: Alignment.centerRight,
          child: TextScroll(
            _controller.interestPerSecond,
            style: defaultTextStyle(20),
            textAlign: TextAlign.right,
            mode: TextScrollMode.bouncing,
            velocity: const Velocity(pixelsPerSecond: Offset(20, 20)),
            pauseBetween: const Duration(seconds: 3),
            selectable: false,
          ),
        ),
  );

  Widget _buildPropertiesList() => Observer(
      builder: (_) => ListView.separated(
            separatorBuilder: (_, index) => _propertiesSeparator(),
            itemCount: _controller.models.length,
            itemBuilder: (context, index) {
              final item = _controller.models.elementAt(index);
              return PropertyViewHolder(
                model: item,
                onBuy: () => _controller.buyProperty(item.offer),
              );
            },
            padding: const EdgeInsets.all(8),
          ));

  Widget _propertiesSeparator() => const Divider(//TODO make a widget
        color: Color(0xFFD5A800),
        thickness: 0.8,
      );
}
