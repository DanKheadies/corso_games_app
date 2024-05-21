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
      title: Score(
        wordsInOrderFound: wordsInOrderFound,
      ),
      children: <Widget>[
        const Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        HoneygramBreakdown(
          validWords: validWords,
          wordsInOrderFound: wordsInOrderFound,
        )
      ],
    );
  }
}
