import 'dart:async';
import 'dart:math';

import 'package:corso_games_app/models/colors/cs_settings_arguments.dart';
import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/colors_slide/cs_settings_screen.dart';
import 'package:corso_games_app/widgets/colors_slide/controller.dart';
import 'package:corso_games_app/widgets/colors_slide/game_board.dart';
import 'package:corso_games_app/widgets/colors_slide/game_piece.dart';
import 'package:corso_games_app/widgets/colors_slide/score.dart';
import 'package:corso_games_app/widgets/colors_slide/size.dart';
import 'package:corso_games_app/widgets/colors_slide/timer.dart';
import 'package:corso_games_app/widgets/screen_info.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class ColorsSlideScreen extends StatefulWidget {
  static const String id = 'colors-slide';

  const ColorsSlideScreen({Key? key}) : super(key: key);

  @override
  State<ColorsSlideScreen> createState() => _ColorsSlideScreenState();
}

class _ColorsSlideScreenState extends State<ColorsSlideScreen> {
  ColorsSlideDifficulty currentDifficulty = ColorsSlideDifficulty.threeByThree;
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

  void setDifficulty(Object? difficulty) {
    print(difficulty);
    if (difficulty == ColorsSlideDifficulty.threeByThree) {
      Controller.gridSize = 3;
    } else if (difficulty == ColorsSlideDifficulty.fourByFour) {
      Controller.gridSize = 4;
    } else if (difficulty == ColorsSlideDifficulty.fiveByFive) {
      Controller.gridSize = 5;
    } else if (difficulty == ColorsSlideDifficulty.sevenBySeven) {
      Controller.gridSize = 7;
    } else if (difficulty == ColorsSlideDifficulty.tenByTen) {
      Controller.gridSize = 10;
    } else if (difficulty == ColorsSlideDifficulty.yolo) {
      Controller.gridSize = Random().nextInt(15);
    }

    if (difficulty != ColorsSlideDifficulty.tbd) {
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
      backgroundOverride: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Size(),
              Score(pieces: pieces),
              Timer(),
            ],
          ),
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
                  arguments: CSSettingsArguments(currentDifficulty),
                );
                setDifficulty(result);
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
