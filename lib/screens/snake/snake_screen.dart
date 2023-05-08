import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class SnakeScreen extends StatefulWidget {
  static const String routeName = '/snake';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SnakeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SnakeScreen({super.key});

  @override
  State<SnakeScreen> createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen> {
  @override
  Widget build(BuildContext context) {
    print('screen height: ${MediaQuery.of(context).size.height}');
    return ScreenWrapper(
      title: 'Snake',
      infoTitle: 'Snake',
      infoDetails:
          'Swipe the screen to change the snake\'s direction. Eat the food, avoid yourself!',
      button: 'Leggooo!',
      backgroundOverride: Theme.of(context).scaffoldBackgroundColor,
      content: BlocBuilder<SnakeBloc, SnakeState>(
        builder: (context, state) {
          if (state.snakeStatus == SnakeStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.snakeStatus != SnakeStatus.error) {
            return SnakeBoard(
              food: state.food,
              gameSpeed: state.gameSpeed,
              numberOfSquares: state.numberOfSquares,
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
      screenFunction: (String string) {
        if (string == 'drawerOpen') {
          print('open');
          // context.read<SnakeBloc>().add(
          //       const UpdateSnakeBoard(
          //         snakeStatus: SnakeStatus.pause,
          //       ),
          //     );
        } else if (string == 'drawerClose') {
          print('close');
          // context.read<SnakeBloc>().add(
          //       const UpdateSnakeBoard(
          //         snakeStatus: SnakeStatus.play,
          //       ),
          //     );
        } else if (string == 'drawerNavigate') {
          print('nav');
          // context.read<SnakeBloc>().add(
          //       const UpdateSnakeBoard(
          //         snakeStatus: SnakeStatus.reset,
          //       ),
          //     );
        }
      },
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Settings',
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
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
      floatingButton: BlocBuilder<SnakeBloc, SnakeState>(
        builder: (context, state) {
          if (state.snakeStatus != SnakeStatus.error) {
            return FloatingActionButton(
              // onPressed: startGame,
              onPressed: () {
                print('start or reset: ${state.snakeStatus}');
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
              child: IconButton(
                icon: Icon(
                  // gameStatus == 'pause'
                  state.snakeStatus != SnakeStatus.play
                      ? Icons.play_arrow
                      : Icons.settings_backup_restore_rounded,
                  color: Theme.of(context).colorScheme.background,
                  size: 30,
                ),
                // onPressed: startGame,
                onPressed: () {
                  print('start or reset: ${state.snakeStatus}');
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
                  color: Theme.of(context).colorScheme.background,
                  size: 30,
                ),
                onPressed: () => print('Error'),
              ),
            );
          }
        },
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
