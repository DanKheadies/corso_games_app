import 'dart:async';

import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/colors_slide/cs_settings_screen.dart';
import 'package:corso_games_app/widgets/colors_slide/controller.dart';
import 'package:corso_games_app/widgets/colors_slide/game_board.dart';
import 'package:corso_games_app/widgets/colors_slide/game_piece.dart';
import 'package:corso_games_app/widgets/colors_slide/score.dart';
import 'package:corso_games_app/widgets/screen_info.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class ColorsSlideScreen extends StatefulWidget {
  static const String id = 'colors-slide';

  const ColorsSlideScreen({Key? key}) : super(key: key);

  @override
  State<ColorsSlideScreen> createState() => _ColorsSlideScreenState();
}

class _ColorsSlideScreenState extends State<ColorsSlideScreen> {
  late StreamSubscription _eventStream;
  List<GamePiece> pieces = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      pieces = [];
    });
    _eventStream = Controller.listen(onAction);
    Controller.start(context);
  }

  void onAction(dynamic data) {
    setState(() {
      pieces = Controller.pieces;
    });
  }

  void setDifficulty(String difficulty) {
    if (difficulty == 'ColorsSlideDifficulty.easy') {
      Controller.gridSize = 7;
    } else if (difficulty == 'ColorsSlideDifficulty.medium') {
      Controller.gridSize = 5;
    } else if (difficulty == 'ColorsSlideDifficulty.hard') {
      Controller.gridSize = 4;
    } else if (difficulty == 'ColorsSlideDifficulty.harder') {
      Controller.gridSize = 10;
    } else if (difficulty == 'ColorsSlideDifficulty.wtf') {
      Controller.gridSize = 3;
    }

    if (difficulty != 'ColorsSlideDifficulty.tbd') {
      Controller.restart(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _eventStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Colors Slide',
      infoTitle: 'Colors Slide',
      infoDetails:
          'Like 2048 but with colors! Tap to spawn a new circle. Swipe up, down, left or right to move and merge circles. Merging circles of similar colors gives you points and changes their combined color.\n\nGood luck, have fun!',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScoreView(pieces: pieces),
          GameBoard(pieces: pieces),
          const SizedBox(),
          const SizedBox(),
        ],
      ),
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.tertiary,
        shape: const CircularNotchedRectangle(),
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
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  CSSettingsScreen.id,
                );
                setDifficulty(result.toString());
              },
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
      floatingButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          icon: const Icon(
            Icons.settings_backup_restore_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              pieces = [];
            });
            Controller.restart(context);
          },
        ),
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
