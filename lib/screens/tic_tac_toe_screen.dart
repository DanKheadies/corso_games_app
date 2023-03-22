import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:corso_games_app/providers/providers.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class TicTacToeScreen extends StatelessWidget {
  // static const String id = 'tic-tac-toe';
  static const String routeName = '/tic-tac-toe';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const TicTacToeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const TicTacToeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Tic Tac Toe',
      infoTitle: 'Tic Tac Toe',
      infoDetails: 'Play with a friend. Or don\'t..',
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
                  TicTacToeBoard(),
                ],
              ),
              const Results(),
            ],
          ),
        ),
      ),
      screenFunction: (String string) {},
      bottomBar: const SizedBox(),
    );
  }
}
