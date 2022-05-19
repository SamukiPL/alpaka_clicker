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
      ..style = PaintingStyle.fill;
    Paint border = Paint()
      ..shader = ui.Gradient.linear(
          Offset(size.width, 0), Offset(size.width, 40), [const Color(0xFFD5A800), const Color(0xFFF1D000)])
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height * 0.1); // Start
    path.lineTo(size.width * 0.485, size.height * -0.4);
    //cross
    path.lineTo(size.width * 0.485, -30);
    path.lineTo(size.width * 0.44, -30);
    path.lineTo(size.width * 0.44, -40);
    path.lineTo(size.width * 0.485, -40);
    path.lineTo(size.width * 0.485, -55);
    path.lineTo(size.width * 0.515, -55);
    path.lineTo(size.width * 0.515, -40);
    path.lineTo(size.width * 0.56, -40);
    path.lineTo(size.width * 0.56, -30);
    path.lineTo(size.width * 0.515, -30);
    path.lineTo(size.width * 0.515, size.height * 0.1);
    path.lineTo(size.width * 0.75, size.height * -0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
