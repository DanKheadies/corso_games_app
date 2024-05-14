import 'package:corso_games_app/providers/providers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicTacToeScreen extends StatelessWidget {
  const TicTacToeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Tic Tac Toe',
      bottomBar: const SizedBox(),
      infoTitle: 'Tic Tac Toe',
      infoDetails: 'Play with a friend. Or don\'t..',
      screenFunction: (_) {},
      child: ChangeNotifierProvider(
        create: (context) => GameProvider(),
        child: const SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  WhoseMove(),
                  TicTacToeBoard(),
                ],
              ),
              Results(),
            ],
          ),
        ),
      ),
    );
  }
}
