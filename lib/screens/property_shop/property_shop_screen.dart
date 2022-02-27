import 'package:alpaka_clicker/screens/property_shop/property_shop_controller.dart';
import 'package:alpaka_clicker/util/widgets/disposable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PropertyShopScreen extends StatelessWidget {
  late final PropertyShopController _controller = GetIt.instance.get<PropertyShopController>();

  PropertyShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.initializeMoneyUpdate();
    return DisposableWidget(
      child: Scaffold(
        body: Center(
          child: Observer(
            builder: (_) => Text(
              _controller.actualMoney
            ),
          ),
        ),
      ),
      dispose: () {
        _controller.dispose();
      },
    );
  }

}