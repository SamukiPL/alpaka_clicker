import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Papaj Gradient
/// ..shader = ui.Gradient.linear(
///     Offset(size.width, 0),
///     const Offset(10, 10),
///     [const Color(0xFFCE9A2F), const Color(0xFFEEBB86)])
class NavigationBarPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height * 0.1); // Start
    path.quadraticBezierTo(
        size.width * 0.5, size.height * -0.4, size.width, size.height * 0.1);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
