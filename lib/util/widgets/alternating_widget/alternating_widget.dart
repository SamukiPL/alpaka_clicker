import 'package:alpaka_clicker/util/widgets/alternating_widget/alternating_controller.dart';
import 'package:alpaka_clicker/util/widgets/disposable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class AlternatingWidget extends StatelessWidget {
  final AlternatingController _controller = GetIt.instance.get<AlternatingController>();

  final Widget firstWidget;
  final Widget secondWidget;

  AlternatingWidget({Key? key, required this.firstWidget, required this.secondWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisposableWidget(
      initialize: () => _controller.initialize(),
      child: Observer(
        builder: (_) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 333),
          child: (_controller.currentVisible == CurrentAlternatingWidget.first) ? firstWidget : secondWidget,
        ),
      ),
      dispose: () => _controller.dispose(),
    );
  }
}
