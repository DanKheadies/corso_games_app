import 'package:flutter/material.dart';

class HoneygramBreakdown extends StatelessWidget {
  final List<String> validWords;
  final List<String> wordsInOrderFound;

  const HoneygramBreakdown({
    super.key,
    required this.validWords,
    required this.wordsInOrderFound,
  });

  @override
  Widget build(BuildContext context) {
    // Iterate over word lengths.  List X of X.
    Map<int, int> validCounts = <int, int>{};
    for (String word in validWords) {
      int count = validCounts[word.length] ?? 0;
      validCounts[word.length] = count + 1;
    }
    Map<int, int> foundCounts = <int, int>{};
    for (String word in wordsInOrderFound) {
      int count = foundCounts[word.length] ?? 0;
      foundCounts[word.length] = count + 1;
    }

    List<int> lengths = validCounts.keys.toList();
    lengths.sort();

    return Column(
      children: [
        for (int length in lengths)
          Text(
            "$length : ${foundCounts[length] ?? 0} of ${validCounts[length]}",
          ),
      ],
    );
  }
}
