import 'package:flutter/material.dart';

class LilBird extends StatelessWidget {
  final double birdHeight;
  final double birdWidth;
  final double birdY;
  final double screenHeight;

  const LilBird({
    super.key,
    required this.birdHeight,
    required this.birdWidth,
    required this.birdY,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        0,
        (2 * birdY + birdHeight) / (2 - birdHeight),
      ),
      child: Image.asset(
        'assets/images/tappy_bird/tappy-bird.png',
        fit: BoxFit.fill,
        height: screenHeight * (3 / 4) * (birdHeight / 2),
        width: screenHeight * (birdWidth / 2),
      ),
    );
  }
}
