import 'dart:ui' as ui show Gradient;

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
      ..shader = ui.Gradient.linear(
          Offset(size.width, 0),
          const Offset(10, 10),
          [const Color(0xFFCE9A2F), const Color(0xFFEEBB86)])
      ..style = PaintingStyle.fill;
    Paint border = Paint()
      ..shader = ui.Gradient.linear(
          Offset(size.width, 0),
          Offset(size.width, 10),
          [const Color(0x56000000), const Color(0x00000000)])
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height * 0.1); // Start
    path.quadraticBezierTo(
        size.width * 0.5, size.height * -0.4, size.width, size.height * 0.1);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
