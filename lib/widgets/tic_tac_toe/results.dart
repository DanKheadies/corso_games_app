import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:corso_games_app/providers/tic_tac_toe/game_provider.dart';

class Results extends StatelessWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameProvider state = context.watch<GameProvider>();
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin:
          EdgeInsets.only(bottom: size.height * 0.04, top: size.height * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Player 1',
                style: TextStyle(
                  fontSize: state.getAdaptiveTextSize(context, 16),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: size.height * 0.012),
              Text(
                '${state.xWins}',
                style: TextStyle(
                  fontSize: state.getAdaptiveTextSize(context, 40),
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w200,
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                'Draws',
                style: TextStyle(
                    fontSize: state.getAdaptiveTextSize(context, 16),
                    // color: Colors.grey[800],
                    color: Theme.of(context).colorScheme.surface),
              ),
              SizedBox(height: size.height * 0.012),
              Text(
                '${state.draws}',
                style: TextStyle(
                  fontSize: state.getAdaptiveTextSize(context, 40),
                  // color: Colors.grey[800],
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Player 2',
                style: TextStyle(
                  fontSize: state.getAdaptiveTextSize(context, 16),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              SizedBox(height: size.height * 0.012),
              Text(
                '${state.oWins}',
                style: TextStyle(
                  fontSize: state.getAdaptiveTextSize(context, 40),
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
