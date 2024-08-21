import 'package:flutter/material.dart';

class BallBounceScore extends StatelessWidget {
  final int score;

  const BallBounceScore({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      score.toString(),
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 30,
      ),
    );
  }
}
