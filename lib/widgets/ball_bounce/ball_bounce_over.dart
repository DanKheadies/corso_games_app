import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BallBounceOver extends StatefulWidget {
  final Game game;

  const BallBounceOver({
    super.key,
    required this.game,
  });

  @override
  State<BallBounceOver> createState() => _BallBounceOverState();
}

class _BallBounceOverState extends State<BallBounceOver> {
  @override
  void initState() {
    super.initState();

    context.read<BallBounceCubit>().gameOver();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<BallBounceCubit, BallBounceState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'GAME OVER',
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
                  BallBounceScore(
                    score: state.score,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'HIGHEST SCORE',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  BallBounceScore(
                    score: state.highestScore,
                  ),
                  const SizedBox(height: 20),
                  BallBounceButton(
                    title: 'TRY AGAIN',
                    onPressed: () {
                      (widget.game as BallBounceGame).resetGame(context);
                    },
                    color: Theme.of(context).colorScheme.primary,
                    width: 200,
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
