import 'package:alpaka_clicker/util/widgets/money_counters/money_counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class MoneyCounter extends StatelessWidget {
  late final MoneyCounterController _controller =
      GetIt.instance.get<MoneyCounterController>();

  final TextStyle textStyle;

  MoneyCounter(
      {Key? key,
      this.textStyle = const TextStyle(
        color: Color(0xFFD5A800),
        fontSize: 18,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.initializeMoneyUpdate();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 4),
          child: Observer(
            builder: (_) => Text(
              _controller.actualMoney,
              style: textStyle,
            ),
          ),
        ),
        Image.asset(
          "assets/images/kremowka.png",
          height: 24,
          width: 24,
        )
      ],
    );
  }
}
