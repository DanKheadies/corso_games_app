import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class MinesweeperScreen extends StatefulWidget {
  static const String routeName = '/minesweeper';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const MinesweeperScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const MinesweeperScreen({Key? key}) : super(key: key);

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  // bool showTimer = false;
  // bool resetGame = false;
  // MinesweeperDifficulty currentDifficulty = MinesweeperDifficulty.easy;
  // MinesweeperDifficulty oldDifficulty = MinesweeperDifficulty.easy;
  String timerStatus = '';

  // void setDifficulty(Object? difficulty) {
  //   if (difficulty == MinesweeperDifficulty.easy) {
  //     setState(() {
  //       currentDifficulty = MinesweeperDifficulty.easy;
  //     });
  //   } else if (difficulty == MinesweeperDifficulty.medium) {
  //     setState(() {
  //       currentDifficulty = MinesweeperDifficulty.medium;
  //     });
  //   } else if (difficulty == MinesweeperDifficulty.hard) {
  //     setState(() {
  //       currentDifficulty = MinesweeperDifficulty.hard;
  //     });
  //   } else if (difficulty == MinesweeperDifficulty.harder) {
  //     setState(() {
  //       currentDifficulty = MinesweeperDifficulty.harder;
  //     });
  //   } else if (difficulty == MinesweeperDifficulty.wtf) {
  //     setState(() {
  //       currentDifficulty = MinesweeperDifficulty.wtf;
  //     });
  //   }

  //   if (difficulty != oldDifficulty) {
  //     setState(() {
  //       oldDifficulty = difficulty as MinesweeperDifficulty;
  //       resetGame = true;
  //       timerStatus = 'reset';
  //     });
  //     Timer(const Duration(milliseconds: 100), () {
  //       setState(() {
  //         resetGame = false;
  //         timerStatus = '';
  //       });
  //     });
  //   }
  // }

  // void checkTimer(bool showTimer) {
  //   if (showTimer != showTimer) {
  //     setState(() {
  //       resetGame = true;
  //     });
  //     Timer(const Duration(milliseconds: 100), () {
  //       setState(() {
  //         resetGame = false;
  //       });
  //     });
  //   }
  // }

  // void handleTimer() {
  //   setState(() {
  //     timerStatus = 'reset';
  //   });
  //   Timer(const Duration(milliseconds: 100), () {
  //     setState(() {
  //       timerStatus = '';
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Minesweeper',
      infoTitle: 'Minesweeper',
      infoDetails: 'Press to pop a mine. Long press to set a flag.',
      backgroundOverride:
          Theme.of(context).colorScheme.background.withOpacity(0.825),
      content: BlocBuilder<MinesweeperBloc, MinesweeperState>(
        builder: (context, state) {
          // Reset on difficulty change
          // if (state.resetMinesweeper) {
          //   // cont.restart(
          //   //   context,
          //   //   state.size,
          //   //   state.pieces,
          //   //   state.indexMap,
          //   // );
          //   context.read<ColorsSlideBloc>().add(
          //         ToggleColorsSlideReset(),
          //       );
          // }

          if (state.mineStatus != MinesweeperStatus.error) {
            return MinesweeperGame(
              resetMinesweeper: state.resetMinesweeper,
              showMineTimer: state.showMineTimer,
              mineDifficulty: state.mineDifficulty,
              mineTimerSeconds: state.mineTimerSeconds,
              bombProbability: state.bombProbability,
              maxProbability: state.maxProbability,
              bombCount: state.bombCount,
              squaresLeft: state.squaresLeft,
              board: state.mineBoard,
              openedSquares: state.openedSquares,
              flaggedSquares: state.flaggedSquares,
            );
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
      screenFunction: (String string) {
        if (string == 'drawerOpen') {
          setState(() {
            timerStatus = 'pause';
          });
        } else if (string == 'drawerClose') {
          setState(() {
            timerStatus = 'resume';
          });
        } else if (string == 'drawerNavigate') {
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
        color: Theme.of(context).colorScheme.secondary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<MinesweeperBloc, MinesweeperState>(
              builder: (context, state) {
                if (state.mineStatus != MinesweeperStatus.error) {
                  return IconButton(
                    tooltip: 'Settings',
                    icon: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.background,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        MSSettingsScreen.routeName,
                      ).then(
                        (value) {
                          if (state.resetMinesweeper) {
                            // cont.restart(
                            //   context,
                            //   state.size,
                            //   state.pieces,
                            //   state.indexMap,
                            // );
                          }
                        },
                      );
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(
                      Icons.warning,
                      color: Theme.of(context).colorScheme.background,
                      size: 30,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'There is an error.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            // IconButton(
            //   tooltip: 'Settings',
            //   icon: Icon(
            //     Icons.settings,
            //     color: Theme.of(context).colorScheme.background,
            //     size: 30,
            //   ),
            //   onPressed: () async {
            //     final result = await Navigator.pushNamed(
            //       context,
            //       MSSettingsScreen.routeName,
            //       arguments: [
            //         currentDifficulty,
            //         showTimer,
            //       ],
            //     );
            //     result as Map;
            //     setDifficulty(result['difficulty']);
            //     checkTimer(result['timer']);
            //     setState(() {
            //       currentDifficulty =
            //           result['difficulty'] as MinesweeperDifficulty;
            //       showTimer = result['timer'];
            //     });
            //   },
            // ),
            IconButton(
              tooltip: 'Share',
              icon: Icon(
                Icons.ios_share_outlined,
                color: Theme.of(context).colorScheme.background,
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
