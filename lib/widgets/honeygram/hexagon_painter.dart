import 'dart:math';

import 'package:flutter/material.dart';

class HexagonPainter extends CustomPainter {
  final Color color;
  Path? lastDrawnPath;

  HexagonPainter({
    required this.color,
    this.lastDrawnPath,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const angleIncrement = pi / 3.0;
    const count = 6;
    List<Offset> points = [];
    var radius = size.shortestSide / 2.0;
    var center = size.center(Offset.zero);

    for (int i = 0; i < count; ++i) {
      var angle = i * angleIncrement;
      points.add(center + Offset(cos(angle), sin(angle)) * radius);
    }

    var path = Path();
    var paint = Paint();
    path.addPolygon(points, true);
    paint.color = color;
    canvas.drawPath(path, paint);

    lastDrawnPath = path;
  }

  @override
  bool? hitTest(Offset position) {
    return lastDrawnPath?.contains(position);
  }

  @override
  bool shouldRepaint(covariant HexagonPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
