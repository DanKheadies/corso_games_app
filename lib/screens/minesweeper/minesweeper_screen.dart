import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MinesweeperScreen extends StatefulWidget {
  const MinesweeperScreen({super.key});

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  // String timerStatus = '';

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Minesweeper',
      backgroundColor:
          Theme.of(context).colorScheme.onSurface.withOpacity(0.825),
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
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
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 30,
                    ),
                    onPressed: () {
                      context.goNamed('minesweeperSettings');
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(
                      Icons.warning,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 30,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('There is an error.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            // IconButton(
            //   tooltip: 'Share',
            //   icon: Icon(
            //     Icons.ios_share_outlined,
            //     color: Theme.of(context).colorScheme.onSurface,
            //     size: 30,
            //   ),
            //   onPressed: () => showScreenInfo(
            //     context,
            //     'Coming Soon',
            //     'You\'ll be able to share your high score soon!',
            //     false,
            //     TextAlign.center,
            //     'Oh Boy',
            //   ),
            // ),
            BlocBuilder<MinesweeperBloc, MinesweeperState>(
              builder: (context, state) {
                if (state.mineStatus != MinesweeperStatus.error) {
                  return IconButton(
                    tooltip: 'Share',
                    icon: Icon(
                      Icons.ios_share_outlined,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 30,
                    ),
                    onPressed: () async {
                      final con = context.read<MinesweeperBloc>();
                      await HydratedBloc.storage.clear();
                      // context.read<ColorsSlideBloc>().add(
                      //       UpdateColorsSlideScore(
                      //         increaseAmount: 1,
                      //         reset: false,
                      //       ),
                      //     );
                      con.add(
                        ToggleMinesweeperReset(),
                      );
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(
                      Icons.warning,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 30,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('There is an error.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      infoTitle: 'Minesweeper',
      infoDetails: 'Press to pop a mine. Long press to set a flag.',
      screenFunction: (String string) {
        if (string == 'drawerOpen') {
          // setState(() {
          //   timerStatus = 'pause';
          // });
          // context.read<MinesweeperBloc>().add(
          //       UpdateMinesweeperTimer(
          //         mineTimerSeconds: mineTimerSeconds,
          //         mineTimerPauseSeconds: mineTimerPauseSeconds,
          //         mineTimerStatus: mineTimerStatus,
          //       ),
          //     );
        } else if (string == 'drawerClose') {
          // setState(() {
          //   timerStatus = 'resume';
          // });
        } else if (string == 'drawerNavigate') {
          // setState(() {
          //   timerStatus = 'stop';
          // });
        }
        // Timer(const Duration(milliseconds: 100), () {
        //   setState(() {
        //     timerStatus = '';
        //   });
        // });
      },
      child: BlocBuilder<MinesweeperBloc, MinesweeperState>(
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
              mineTimerPauseSeconds: state.mineTimerPauseSeconds,
              mineTimerStatus: state.mineTimerStatus,
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
    );
  }
}
