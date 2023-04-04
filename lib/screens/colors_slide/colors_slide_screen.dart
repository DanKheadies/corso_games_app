import 'dart:async';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class ColorsSlideScreen extends StatefulWidget {
  static const String routeName = '/colors-slide';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ColorsSlideScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ColorsSlideScreen({Key? key}) : super(key: key);

  @override
  State<ColorsSlideScreen> createState() => _ColorsSlideScreenState();
}

class _ColorsSlideScreenState extends State<ColorsSlideScreen> {
  Controller cont = Controller();
  String timerStatus = '';

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Colors Slide',
      infoTitle: 'Colors Slide',
      infoDetails:
          'Like 2048 but with colors!! Tap to add aother circle. Swipe up, down, left or right to move and merge circles. Merging circles of similar colors gives you points and changes their combined color.',
      backgroundOverride: Colors.transparent,
      content: BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
        builder: (context, state) {
          // Reset on difficulty change
          if (state.resetColors) {
            cont.restart(
              context,
              state.size,
              state.pieces,
              state.indexMap,
            );
            context.read<ColorsSlideBloc>().add(
                  ToggleColorsSlideReset(),
                );
          }

          if (state.status != ColorsSlideStatus.error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CSSize(),
                    const Score(),
                    if (state.showTimer)
                      CSTimer(
                        timer: state.showTimer,
                        timerStatus: timerStatus,
                      ),
                  ],
                ),
                GameBoard(
                  pieces: state.pieces,
                  cont: cont,
                  gridSize: state.size,
                  index: state.indexMap,
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
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
              builder: (context, state) {
                if (state.status != ColorsSlideStatus.error) {
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
                        CSSettingsScreen.routeName,
                      ).then(
                        (value) {
                          if (state.resetColors) {
                            cont.restart(
                              context,
                              state.size,
                              state.pieces,
                              state.indexMap,
                            );
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
      floatingButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
          builder: (context, state) {
            if (state.status != ColorsSlideStatus.error) {
              return IconButton(
                icon: Icon(
                  Icons.settings_backup_restore_rounded,
                  color: Theme.of(context).colorScheme.background,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    timerStatus = 'reset';
                  });
                  cont.restart(
                    context,
                    state.size,
                    state.pieces,
                    state.indexMap,
                  );
                  Timer(const Duration(milliseconds: 100), () {
                    setState(() {
                      timerStatus = '';
                    });
                  });
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
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
