import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:alpaka_clicker/util/widgets/money_counters/money_counter_controller.dart';
import 'package:alpaka_clicker/util/widgets/money_counters/money_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class FloatingMoneyCounter extends StatelessWidget {
  late final MoneyCounterController _controller = GetIt.instance.get<MoneyCounterController>();

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  FloatingMoneyCounter({Key? key, this.left, this.top, this.right, this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.initializeMoneyUpdate();
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: Container(
        width: 150,
        padding: const EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
        decoration: defaultDecoration(),
        child: MoneyCounter(),
      ),
    );
  }
}
