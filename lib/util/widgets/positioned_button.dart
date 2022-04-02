import 'package:alpaka_clicker/util/widgets/buttons/clicker_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PositionedButton extends StatelessWidget {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  final EdgeInsetsGeometry padding;

  final Widget child;

  final Function onTap;

  const PositionedButton(
      {Key? key,
      required this.child,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.padding = const EdgeInsets.all(8),
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        child: ClickerButton(
          child: child,
          onTap: onTap,
          padding: padding,
        ));
  }
}
