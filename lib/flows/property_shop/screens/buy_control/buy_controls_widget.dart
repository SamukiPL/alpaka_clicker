import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:alpaka_clicker/flows/property_shop/domain/models/buy_amount.dart';
import 'package:alpaka_clicker/flows/property_shop/screens/buy_control/buy_controls_controller.dart';
import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class BuyControlsWidget extends StatelessWidget {
  final BuyControlsController _controller = GetIt.instance.get<BuyControlsController>();

  final _buttonTextStyle = const TextStyle(
    color: BaseColors.primary,
    fontSize: 16,
  );

  BuyControlsWidget({Key? key}) : super(key: key);

  BoxDecoration get _selectedDecoration => defaultDecoration().copyWith(color: BaseColors.primary);

  TextStyle get _selectedTextStyle => _buttonTextStyle.copyWith(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _controlWidget(BuyAmount.one),
          _controlWidget(BuyAmount.ten),
          _controlWidget(BuyAmount.hundred),
        ],
      ),
    );
  }

  Widget _controlWidget(BuyAmount current) {
    final selected = _controller.selected;
    final decoration = (selected == current) ? _selectedDecoration : defaultDecoration();
    final textStyle = (selected == current) ? _selectedTextStyle : _buttonTextStyle;
    return Container(
      height: 50,
      width: 50,
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _controller.setSelected(current),
          customBorder: RoundedRectangleBorder(borderRadius: defaultRadius()),
          child: Center(
              child: Text(
            current.getControlString(),
            style: textStyle,
          )),
        ),
      ),
    );
  }
}

extension BuyControlsExt on BuyAmount {
  String getControlString() {
    switch (this) {
      case BuyAmount.one:
        return "+1";
      case BuyAmount.ten:
        return "+10";
      case BuyAmount.hundred:
        return "+100";
      default:
        throw ArgumentError("There is no more controls");
    }
  }
}
