// import 'package:corso_games_app/providers/stack_stacks/stack_stacks_provider.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class StacksGameDialog extends StatelessWidget {
  final bool gameWon;
  final Function resetGame;

  const StacksGameDialog({
    super.key,
    required this.gameWon,
    required this.resetGame,
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
              gameWon ? "You won!" : "You lost..",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(flex: 2),
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
          const Spacer(flex: 2),
          Flexible(
            flex: 10,
            child: TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
              },
              child: Text(
                gameWon ? 'Play again' : 'Try again',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  static Future<void> openStacksGameDialog(
    BuildContext context,
    bool gameWon,
    Function resetGame,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => StacksGameDialog(
        gameWon: gameWon,
        resetGame: resetGame,
      ),
    );
  }
}
