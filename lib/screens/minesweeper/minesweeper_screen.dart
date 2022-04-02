import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/minesweeper/ms_settings_screen.dart';
import 'package:corso_games_app/widgets/minesweeper/game_activity.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';
import 'package:corso_games_app/widgets/screen_info.dart';

class MinesweeperScreen extends StatefulWidget {
  static const String id = 'minesweeper';

  const MinesweeperScreen({Key? key}) : super(key: key);

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  void setDifficulty(String difficulty) {
    // if (difficulty == 'ColorsSlideDifficulty.easy') {
    //   Controller.gridSize = 7;
    // } else if (difficulty == 'ColorsSlideDifficulty.medium') {
    //   Controller.gridSize = 5;
    // } else if (difficulty == 'ColorsSlideDifficulty.hard') {
    //   Controller.gridSize = 4;
    // } else if (difficulty == 'ColorsSlideDifficulty.harder') {
    //   Controller.gridSize = 10;
    // } else if (difficulty == 'ColorsSlideDifficulty.wtf') {
    //   Controller.gridSize = 3;
    // }

    // if (difficulty != 'ColorsSlideDifficulty.tbd') {
    //   Controller.restart(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Minesweeper',
      infoTitle: 'Minesweeper',
      infoDetails: 'Good luck, have fun!',
      backgroundOverride: Colors.grey,
      content: const GameActivity(),
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.tertiary,
        // shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Settings',
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => showScreenInfo(
                context,
                'Coming Soon',
                'You\'ll be able to adjust the difficulty and time yourself soon!',
              ),
              // onPressed: () async {
              //   // final result = await Navigator.pushNamed(
              //   //   context,
              //   //   MSSettingsScreen.id,
              //   // );
              //   // setDifficulty(result.toString());
              // },
            ),
            IconButton(
              tooltip: 'Share',
              icon: const Icon(
                Icons.ios_share_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => showScreenInfo(
                context,
                'Coming Soon',
                'You\'ll be able to share your high score soon!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
