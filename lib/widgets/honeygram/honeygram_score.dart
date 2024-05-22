import 'package:corso_games_app/models/models.dart';
import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final List<String> wordsInOrderFound;

  const Score({
    super.key,
    required this.wordsInOrderFound,
  });

  int computeScore(List<String> words) {
    return words.fold(
      0,
      (sum, word) => sum + HoneygramBoard.scoreForWord(word),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text('Score: ${computeScore(wordsInOrderFound)}');
  }
}
