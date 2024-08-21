import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ColorsSlideScreen extends StatefulWidget {
  const ColorsSlideScreen({super.key});

  @override
  State<ColorsSlideScreen> createState() => _ColorsSlideScreenState();
}

class _ColorsSlideScreenState extends State<ColorsSlideScreen> {
  ColorsController cont = ColorsController();

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Colors Slide',
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
              builder: (context, state) {
                if (state.colorsStatus != ColorsSlideStatus.error) {
                  return IconButton(
                    tooltip: 'Settings',
                    icon: Icon(
                      Icons.settings,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 30,
                    ),
                    onPressed: () {
                      context.goNamed('colorsSlideSettings');
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
            IconButton(
              tooltip: 'Share',
              icon: Icon(
                Icons.ios_share_outlined,
                color: Theme.of(context).colorScheme.onSurface,
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
      flactionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
          builder: (context, state) {
            if (state.colorsStatus != ColorsSlideStatus.error) {
              return IconButton(
                icon: Icon(
                  Icons.settings_backup_restore_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 30,
                ),
                onPressed: () {
                  cont.restart(
                    context,
                    state.colorsSize,
                    state.colorsPieces,
                    state.colorsIndexMap,
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
      ),
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      infoTitle: 'Colors Slide',
      infoDetails:
          'Like 2048 but with colors!! Tap to add aother circle. Swipe up, down, left or right to move and merge circles. Merging circles of similar colors gives you points and changes their combined color.',
      screenFunction: (_) {},
      child: BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
        builder: (context, state) {
          // Reset on difficulty change
          if (state.resetColors) {
            cont.restart(
              context,
              state.colorsSize,
              state.colorsPieces,
              state.colorsIndexMap,
            );
            context.read<ColorsSlideBloc>().add(
                  ToggleColorsSlideReset(),
                );
          }

          if (state.colorsStatus != ColorsSlideStatus.error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CSSize(),
                    ColorsScore(),
                  ],
                ),
                ColorsGameBoard(
                  pieces: state.colorsPieces,
                  cont: cont,
                  gridSize: state.colorsSize,
                  index: state.colorsIndexMap,
                ),
                const SizedBox(),
                const SizedBox(),
              ],
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
