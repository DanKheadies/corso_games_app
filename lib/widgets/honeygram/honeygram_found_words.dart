import 'package:corso_games_app/models/models.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class HoneygramFoundWords extends StatefulWidget {
  final HoneygramBoard board;
  final List<String> wordsInOrderFound;

  const HoneygramFoundWords({
    super.key,
    required this.board,
    required this.wordsInOrderFound,
  });

  @override
  State<HoneygramFoundWords> createState() => _HoneygramFoundWordsState();
}

class _HoneygramFoundWordsState extends State<HoneygramFoundWords> {
  bool expanded = false;

  void expansionChanged(bool newValue) {
    setState(() {
      expanded = newValue;
    });
  }

  String capitalize(String string) {
    return '${string[0].toUpperCase()}${string.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    List<String> capitalizedWords =
        widget.wordsInOrderFound.map(capitalize).toList();
    List<String> alphabeticalOrder = List.from(capitalizedWords);
    alphabeticalOrder.sort();

    return ExpansionTileCard(
      baseColor: Theme.of(context).colorScheme.onSurface,
      expandedTextColor: Theme.of(context).colorScheme.primary,
      onExpansionChanged: expansionChanged,
      subtitle: expanded
          ? null
          : Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '${widget.wordsInOrderFound.length} of ${widget.board.validWords.length}',
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
      title: expanded
          ? Text(
              'Found',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : Text(
              capitalizedWords.reversed.join(', '),
              overflow: TextOverflow.ellipsis,
            ),
      children: [
        Divider(
          color: Theme.of(context).colorScheme.primary,
          height: 1.0,
          thickness: 1.0,
        ),
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: ListView(
            children: alphabeticalOrder
                .map(
                  (word) => ListTile(
                    title: Text(
                      word,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
