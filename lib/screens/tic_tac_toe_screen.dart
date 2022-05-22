import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/coming_soon.dart';
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
      content: const ComingSoon(),
      screenFunction: (String _string) {},
      bottomBar: const BottomAppBar(),
    );
  }
}
