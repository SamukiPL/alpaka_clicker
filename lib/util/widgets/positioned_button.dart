import 'package:alpaka_clicker/theme/decorations.dart';
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
        child: Material(
            color: Colors.white,
            borderRadius: defaultRadius(),
            child: InkWell(
                onTap: () => onTap(),
                child: Container(
                    decoration: buttonDecoration(),
                    padding: padding,
                    child: child))));
  }
}
