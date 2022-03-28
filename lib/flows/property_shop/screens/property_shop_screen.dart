import 'package:alpaka_clicker/flows/property_shop/screens/buy_control/buy_controls_widget.dart';
import 'package:alpaka_clicker/flows/property_shop/screens/property_shop_controller.dart';
import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:alpaka_clicker/util/widgets/money_counters/money_counter_toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PropertyShopScreen extends StatelessWidget {
  final PropertyShopController _controller = GetIt.instance.get<PropertyShopController>();

  PropertyShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MoneyCounterToolbar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
                  decoration: defaultDecoration(),
                  child: const Text("21.37 KM/s"),
                ),
              ),
              Flexible(
                flex: 1,
                child: BuyControlsWidget(),
              )
            ],
          ),
          Expanded(
            child: Observer(
                builder: (_) => ListView.builder(
                    itemCount: _controller.models.length,
                    itemBuilder: (context, index) => Container(
                          decoration: defaultDecoration(),
                          width: 250,
                          height: 250,
                        ))),
          )
        ],
      ),
    );
  }
}
