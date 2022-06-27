import 'package:alpaka_clicker/theme/decorations.dart';
import 'package:flutter/material.dart';

class ClickerButton extends StatelessWidget {
  final Widget child;

  final Function onTap;

  final EdgeInsetsGeometry padding;

  final Color color;

  const ClickerButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: color,
        borderRadius: defaultRadius(),
        child: InkWell(
            onTap: () => onTap(),
            customBorder: RoundedRectangleBorder(borderRadius: defaultRadius()),
            child: Container(decoration: buttonDecoration(), padding: padding, child: child)));
  }
}
