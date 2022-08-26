import 'dart:async';

import 'package:corso_games_app/screens/minesweeper/ms_settings_screen.dart';
import 'package:flutter/material.dart';

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
  bool showTimer = false;
  bool resetGame = false;
  MinesweeperDifficulty currentDifficulty = MinesweeperDifficulty.easy;
  MinesweeperDifficulty oldDifficulty = MinesweeperDifficulty.easy;
  String timerStatus = '';

  void setDifficulty(Object? difficulty) {
    if (difficulty == MinesweeperDifficulty.easy) {
      setState(() {
        currentDifficulty = MinesweeperDifficulty.easy;
      });
    } else if (difficulty == MinesweeperDifficulty.medium) {
      setState(() {
        currentDifficulty = MinesweeperDifficulty.medium;
      });
    } else if (difficulty == MinesweeperDifficulty.hard) {
      setState(() {
        currentDifficulty = MinesweeperDifficulty.hard;
      });
    } else if (difficulty == MinesweeperDifficulty.harder) {
      setState(() {
        currentDifficulty = MinesweeperDifficulty.harder;
      });
    } else if (difficulty == MinesweeperDifficulty.wtf) {
      setState(() {
        currentDifficulty = MinesweeperDifficulty.wtf;
      });
    }

    if (difficulty != oldDifficulty) {
      setState(() {
        oldDifficulty = difficulty as MinesweeperDifficulty;
        resetGame = true;
        timerStatus = 'reset';
      });
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          resetGame = false;
          timerStatus = '';
        });
      });
    }
  }

  void checkTimer(bool _showTimer) {
    if (_showTimer != showTimer) {
      setState(() {
        resetGame = true;
      });
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          resetGame = false;
        });
      });
    }
  }

  void handleTimer() {
    setState(() {
      timerStatus = 'reset';
    });
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        timerStatus = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Minesweeper',
      infoTitle: 'Minesweeper',
      infoDetails: 'Press to pop a mine. Long press to set a flag.',
      backgroundOverride: Colors.grey,
      content: GameActivity(
        difficulty: currentDifficulty,
        resetGame: resetGame,
        timer: showTimer,
        timerStatus: timerStatus,
        timerReset: () {
          handleTimer();
        },
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
                  MSSettingsScreen.id,
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
                      result['difficulty'] as MinesweeperDifficulty;
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
    );
  }
}
