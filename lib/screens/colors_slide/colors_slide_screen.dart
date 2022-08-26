import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/colors_slide/cs_settings_screen.dart';
import 'package:corso_games_app/widgets/colors_slide/controller.dart';
import 'package:corso_games_app/widgets/colors_slide/game_board.dart';
import 'package:corso_games_app/widgets/colors_slide/game_piece.dart';
import 'package:corso_games_app/widgets/colors_slide/score.dart';
import 'package:corso_games_app/widgets/colors_slide/size.dart';
import 'package:corso_games_app/widgets/colors_slide/cs_timer.dart';
import 'package:corso_games_app/widgets/screen_info.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class ColorsSlideScreen extends StatefulWidget {
  static const String id = 'colors-slide';

  const ColorsSlideScreen({Key? key}) : super(key: key);

  @override
  State<ColorsSlideScreen> createState() => _ColorsSlideScreenState();
}

class _ColorsSlideScreenState extends State<ColorsSlideScreen> {
  bool showTimer = false;
  ColorsSlideDifficulty currentDifficulty = ColorsSlideDifficulty.threeByThree;
  ColorsSlideDifficulty oldDifficulty = ColorsSlideDifficulty.threeByThree;
  late StreamSubscription _eventStream;
  List<GamePiece> pieces = [];
  String size = '3x3';
  String timerStatus = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      pieces = [];
    });

    _eventStream = Controller.listen(onAction);

    Timer(
      const Duration(milliseconds: 100),
      () {
        Controller.gridSize = Controller.initGridSize;
        Controller.restart(context);
      },
    );
  }

  void onAction(dynamic data) {
    setState(() {
      pieces = Controller.pieces;
    });
  }

  void setDifficulty(Object? difficulty) {
    if (difficulty == ColorsSlideDifficulty.threeByThree) {
      Controller.gridSize = 3;
      setState(() {
        size = '3x3';
      });
    } else if (difficulty == ColorsSlideDifficulty.fourByFour) {
      Controller.gridSize = 4;
      setState(() {
        size = '4x4';
      });
    } else if (difficulty == ColorsSlideDifficulty.fiveByFive) {
      Controller.gridSize = 5;
      setState(() {
        size = '5x5';
      });
    } else if (difficulty == ColorsSlideDifficulty.sevenBySeven) {
      Controller.gridSize = 7;
      setState(() {
        size = '7x7';
      });
    } else if (difficulty == ColorsSlideDifficulty.tenByTen) {
      Controller.gridSize = 10;
      setState(() {
        size = '10x10';
      });
    } else if (difficulty == ColorsSlideDifficulty.yolo) {
      var rando = Random().nextInt(13) + 2;
      Controller.gridSize = rando;
      setState(() {
        size = '${rando}x$rando';
      });
    }

    if (difficulty != oldDifficulty) {
      Controller.restart(context);
      setState(() {
        oldDifficulty = difficulty as ColorsSlideDifficulty;
        timerStatus = 'reset';
      });
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          timerStatus = '';
        });
      });
    }
  }

  void checkTimer(bool _showTimer) {
    if (_showTimer != showTimer) {
      Timer(const Duration(milliseconds: 100), () {
        Controller.restart(context);
      });
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
          'Like 2048 but with colors!! Tap to add aother circle. Swipe up, down, left or right to move and merge circles. Merging circles of similar colors gives you points and changes their combined color.',
      backgroundOverride: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: showTimer
                ? [
                    Size(size: size),
                    Score(pieces: pieces),
                    CSTimer(
                      timer: showTimer,
                      timerStatus: timerStatus,
                    ),
                  ]
                : [
                    Size(size: size),
                    Score(pieces: pieces),
                  ],
          ),
          GameBoard(pieces: pieces),
          const SizedBox(),
          const SizedBox(),
        ],
      ),
      screenFunction: (String _string) {
        if (_string == 'drawerOpen') {
          setState(() {
            timerStatus = 'pause';
          });
        } else if (_string == 'drawerClose') {
          setState(() {
            timerStatus = 'resume';
          });
        } else if (_string == 'drawerNavigate') {
          setState(() {
            timerStatus = 'stop';
          });
        }
        Timer(const Duration(milliseconds: 100), () {
          setState(() {
            timerStatus = '';
          });
        });
      },
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
                  arguments: {
                    'difficulty': currentDifficulty,
                    'timer': showTimer,
                  },
                );
                result as Map;
                setDifficulty(result['difficulty']);
                checkTimer(result['timer']);
                setState(() {
                  currentDifficulty =
                      result['difficulty'] as ColorsSlideDifficulty;
                  showTimer = result['timer'];
                });
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
                false,
                TextAlign.center,
                'Oh Boy',
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
              timerStatus = 'reset';
            });
            Controller.restart(context);
            Timer(const Duration(milliseconds: 100), () {
              setState(() {
                timerStatus = '';
              });
            });
          },
        ),
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
