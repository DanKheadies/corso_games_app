import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:corso_games_app/providers/tic_tac_toe/game_provider.dart';
import 'package:corso_games_app/widgets/tic_tac_toe/board.dart';
import 'package:corso_games_app/widgets/tic_tac_toe/results.dart';
import 'package:corso_games_app/widgets/tic_tac_toe/whose_move.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class TicTacToeScreen extends StatelessWidget {
  static const String id = 'tic-tac-toe';

  const TicTacToeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Tic Tac Toe',
      infoTitle: 'Tic Tac Toe',
      infoDetails: 'Good luck, have fun!',
      backgroundOverride: Colors.transparent,
      content: ChangeNotifierProvider(
        create: (context) => GameProvider(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                children: const [
                  WhoseMove(),
                  Board(),
                ],
              ),
              const Results(),
            ],
          ),
        ),
      ),
      screenFunction: (String _string) {},
      bottomBar: const BottomAppBar(),
    );
  }
}
