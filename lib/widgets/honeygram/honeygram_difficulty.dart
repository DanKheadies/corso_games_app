import 'package:flutter/material.dart';

class HoneygramDifficulty extends StatelessWidget {
  final double? difficultyPercentile;

  const HoneygramDifficulty({
    super.key,
    this.difficultyPercentile = 0.0,
  });

  String difficultyText(double percentile) {
    if (percentile < 0.05) return "Very Easy";
    if (percentile < 0.15) return "Easy";
    if (percentile < 0.25) return "Medium";
    if (percentile < 0.50) return "Hard";
    return "Insane!";
  }

  @override
  Widget build(BuildContext context) {
    print('difficultyPercentile: $difficultyPercentile');
    return difficultyPercentile == 0.0 || difficultyPercentile == null
        ? const Text("Difficulty: Unknown")
        : Text(
            "Difficulty: ${difficultyText(difficultyPercentile!)} (${(100 * difficultyPercentile!).toInt()}%)",
          );
  }
}
