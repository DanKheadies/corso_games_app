import 'package:corso_games_app/models/models.dart';
import 'package:flutter/material.dart';

class CustomBoardTile extends StatelessWidget {
  const CustomBoardTile({
    Key? key,
    required this.letters,
    required this.letterCount,
    required this.letterIndex,
  }) : super(key: key);

  final List<Letter?> letters;
  final int letterCount;
  final int letterIndex;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    // Set the color of the Board Tile
    Color color = (letterCount > letterIndex)
        // If the eval is equal to pending, no color.
        ? letters[letterIndex]!.evaluation == Evaluation.pending
            // || letters[letterIndex]!.evaluation == null
            ? Colors.transparent
            // If the letter is correct, we use the primary red/pink.
            : letters[letterIndex]!.evaluation == Evaluation.correct
                // ? Colors.lightGreen
                ? Theme.of(context).colorScheme.tertiary
                // If the letter is correct, but not in the right spot, we use a yellow.
                : letters[letterIndex]!.evaluation == Evaluation.present
                    ? Theme.of(context).colorScheme.secondary
                    // : Colors.grey[800] as Color
                    : Theme.of(context).colorScheme.surface.withOpacity(0.825)
        : Colors.transparent;

    // Set the color of the Text
    Color textColor = (letterCount > letterIndex)
        // If the eval is equal to pending, no color.
        ? letters[letterIndex]!.evaluation == Evaluation.missing
            ? Theme.of(context).scaffoldBackgroundColor
            : letters[letterIndex]!.evaluation == Evaluation.pending
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).scaffoldBackgroundColor
        : Colors.black;

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        color: color,
      ),
      child: Center(
        child: (letterCount > letterIndex)
            ? Text(
                letters[letterIndex]!.letter,
                style: TextStyle(
                  color: textColor,
                  // fontSize: 20,
                  fontSize: height * .025,
                ),
              )
            : const Text(''),
      ),
    );
  }
}
