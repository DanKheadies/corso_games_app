import 'package:corso_games_app/helpers/helpers.dart';
import 'package:flutter/material.dart';

class StacksBrickWidget extends StatelessWidget {
  final int colorIndex;

  const StacksBrickWidget({
    super.key,
    required this.colorIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      color: indexToColor(colorIndex),
    );
  }
}
