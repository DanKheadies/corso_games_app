import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/coming_soon.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class MinesweeperScreen extends StatelessWidget {
  static const String id = 'minesweeper';

  const MinesweeperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(
      title: 'Minesweeper',
      infoTitle: 'Minesweeper',
      infoDetails: 'Good luck, have fun!',
      children: ComingSoon(),
    );
  }
}
