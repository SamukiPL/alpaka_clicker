import 'package:alpaka_clicker/base/base_colors.dart';
import 'package:flutter/material.dart';

class RoundedProgressWidget extends StatelessWidget {
  final double value;
  final String displayableValue;
  final double height;
  final BoxDecoration? decoration;
  final Color color;
  final Color backgroundColor;
  final TextStyle textStyle;

  const RoundedProgressWidget(
      {Key? key,
      required this.value,
      required this.displayableValue,
      this.height = 20,
      this.decoration,
      this.color = Colors.amber,
      this.backgroundColor = Colors.white,
      this.textStyle = const TextStyle(color: Colors.white, fontSize: 100)})
      : super(key: key);

  BoxDecoration get containerDecoration => decoration ?? BoxDecoration(
      border: Border.all(color: BaseColors.primary), borderRadius: const BorderRadius.all(Radius.circular(16)));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: containerDecoration,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          LinearProgressIndicator(
            value: value,
            backgroundColor: backgroundColor,
            color: color,
          ),
          FittedBox(
            child: Text(
              displayableValue,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          )
        ],
      ),
    );
  }
}
