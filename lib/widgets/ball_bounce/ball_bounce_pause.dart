import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BallBouncePause extends StatelessWidget {
  final Game game;

  const BallBouncePause({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'PAUSE',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'SCORE',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<BallBounceCubit, BallBounceState>(
                builder: (context, state) {
                  return BallBounceScore(
                    score: state.score,
                  );
                },
              ),
              const SizedBox(height: 20),
              BallBounceButton(
                onPressed: () {
                  (game as BallBounceGame).togglePauseState();
                },
                title: 'CONTINUE',
                color: Theme.of(context).colorScheme.primary,
                width: 200,
              ),
              const SizedBox(height: 20),
              BallBounceButton(
                onPressed: () {
                  (game as BallBounceGame).resetGame(context);
                },
                title: 'RESTART',
                color: Theme.of(context).colorScheme.secondary,
                width: 200,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
