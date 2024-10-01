import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StacksGameDialog extends StatelessWidget {
  final bool gameWon;

  const StacksGameDialog({
    super.key,
    required this.gameWon,
  });

  @override
  Widget build(BuildContext context) {
    return StacksDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 10,
            child: Text(
              gameWon ? "You won!" : "You lost :(",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 10,
            child: SizedBox(
              width: 50,
              child: Image.asset(
                gameWon
                    ? 'assets/images/stack_stacks/in-love.png'
                    : 'assets/images/stack_stacks/sad.png',
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> openStacksGameDialog(
    BuildContext context,
    bool gameWon,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => StacksGameDialog(gameWon: gameWon),
    );
  }
}
