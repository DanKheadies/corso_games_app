import 'package:corso_games_app/widgets/widgets.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class HoneygramProgress extends StatelessWidget {
  final List<String> validWords;
  final List<String> wordsInOrderFound;

  const HoneygramProgress({
    super.key,
    required this.validWords,
    required this.wordsInOrderFound,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      baseColor: Theme.of(context).colorScheme.onSurface,
      expandedTextColor: Theme.of(context).colorScheme.primary,
      title: Score(
        wordsInOrderFound: wordsInOrderFound,
      ),
      children: [
        Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 1.0,
          height: 1.0,
        ),
        const SizedBox(height: 5),
        HoneygramBreakdown(
          validWords: validWords,
          wordsInOrderFound: wordsInOrderFound,
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
