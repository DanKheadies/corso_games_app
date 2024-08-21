import 'dart:io';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SnakeScreen extends StatefulWidget {
  const SnakeScreen({super.key});

  @override
  State<SnakeScreen> createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen> {
  bool hasLeft = false;
  int colNum = 15; // 20

  @override
  Widget build(BuildContext context) {
    // print('screen height: ${MediaQuery.of(context).size.height}');
    // @ 20 columns
    // int squares =
    //     (0.35088 * MediaQuery.of(context).size.height + 335.08772).floor();
    // @ 15 columns
    int squares =
        (0.13158 * MediaQuery.of(context).size.height + 258.1579).floor();
    // Tests:
    // print(squares); // 660
    // int squares = 365; // 380
    // Make sure it's a multiple of 20 / colNum
    // while (squares % 20 != 0) {
    while (squares % colNum != 0) {
      squares -= 1;
    }
    // TODO: Android has room for 2 more rows @ 20 cols
    // Has 2 too many @ 15 cols
    // Find a better way to handle this
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        // squares += 40;
        squares -= colNum * 2;
      }
    }

    return ScreenWrapper(
      screen: 'Snake',
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Settings',
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onSurface,
                size: 30,
              ),
              onPressed: () {
                context.read<SnakeBloc>().add(
                      const UpdateSnakeBoard(
                        snakeStatus: SnakeStatus.pause,
                      ),
                    );
                context.goNamed('snakeSettings');
              },
            ),
            IconButton(
              tooltip: 'Share',
              icon: Icon(
                Icons.ios_share_outlined,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      button: 'Leggooo!',
      infoTitle: 'Snake',
      infoDetails:
          'Swipe the screen to change the snake\'s direction. Eat the food, avoid yourself!',
      flactionButton: BlocBuilder<SnakeBloc, SnakeState>(
        builder: (context, state) {
          if (state.snakeStatus != SnakeStatus.error) {
            return FloatingActionButton(
              onPressed: () {
                context.read<SnakeBloc>().add(
                      UpdateSnakeBoard(
                        snakeStatus: state.snakeStatus == SnakeStatus.pause
                            ? SnakeStatus.unpause
                            : SnakeStatus.reset,
                      ),
                    );
              },
              tooltip: 'Reset',
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: const CircleBorder(),
              child: IconButton(
                icon: Icon(
                  state.snakeStatus != SnakeStatus.play
                      ? Icons.play_arrow
                      : Icons.settings_backup_restore_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 30,
                ),
                onPressed: () {
                  context.read<SnakeBloc>().add(
                        UpdateSnakeBoard(
                          snakeStatus: state.snakeStatus == SnakeStatus.pause ||
                                  state.snakeStatus == SnakeStatus.loaded
                              ? SnakeStatus.unpause
                              : SnakeStatus.reset,
                        ),
                      );
                },
              ),
            );
          } else {
            return FloatingActionButton(
              onPressed: () {
                print('Error');
              },
              tooltip: 'Error',
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                icon: Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 30,
                ),
                onPressed: () => print('Error'),
              ),
            );
          }
        },
      ),
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      screenFunction: (String string) {
        if (string == 'drawerOpen') {
          context.read<SnakeBloc>().add(
                const UpdateSnakeBoard(
                  snakeStatus: SnakeStatus.pause,
                ),
              );
        } else if (string == 'drawerClose') {
          if (!hasLeft) {
            context.read<SnakeBloc>().add(
                  const UpdateSnakeBoard(
                    snakeStatus: SnakeStatus.unpause,
                  ),
                );
          }
        } else if (string == 'drawerNavigate') {
          setState(() {
            hasLeft = true;
          });
        }
      },
      child: BlocBuilder<SnakeBloc, SnakeState>(
        builder: (context, state) {
          if (state.snakeStatus == SnakeStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.snakeStatus != SnakeStatus.error) {
            return SnakeBoard(
              colNum: state.colNum,
              food: state.food,
              gameSpeed: state.gameSpeed,
              numberOfSquares: squares,
              snakePosition: state.snakePosition,
              snakeDirection: state.snakeDirection,
              snakeSpeed: state.snakeSpeed,
              snakeStatus: state.snakeStatus,
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
