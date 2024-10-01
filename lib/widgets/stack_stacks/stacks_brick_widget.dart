import 'package:corso_games_app/helpers/helpers.dart';
import 'package:flutter/material.dart';

class StacksBrickWidget extends StatelessWidget {
  final int colorIndex;
  final double height;

  const StacksBrickWidget({
    super.key,
    required this.colorIndex,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 35,
      height: height / (5 * 4),
      width: double.infinity,
      color: indexToColor(colorIndex),
    );
  }
}
