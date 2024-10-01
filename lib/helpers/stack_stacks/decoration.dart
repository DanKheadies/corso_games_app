import 'package:flutter/material.dart';

// const Color stacksBgColorPrimary = Color(0xFF1d2d44);
// const Color stacksBgColorSecondary = Color(0xFF0d1321);

// const BoxDecoration backgroundDecoration = BoxDecoration(
//   gradient: LinearGradient(
//     colors: [stacksBgColorPrimary, stacksBgColorSecondary],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   ),
// );

Color indexToColor(int index) {
  switch (index) {
    case 1:
      return const Color(0xFF8b4513);
    case 2:
      return const Color(0xFFffb5b5);
    case 3:
      return const Color(0xFFff0000);
    case 4:
      return const Color(0xFFff9100);
    case 5:
      return const Color(0xFF006400);
    case 6:
      return const Color(0xFF00ff00);
    case 7:
      return const Color(0xFF00ffff);
    case 8:
      return const Color(0xFF0000ff);
    case 9:
      return const Color(0xFF4682b4);
    case 10:
      return const Color(0xFF4b0082);
    case 11:
      return const Color(0xFFffff00);
    default:
      return Colors.black;
  }
}
