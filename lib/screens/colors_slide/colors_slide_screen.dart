import 'dart:async';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class ColorsSlideScreen extends StatefulWidget {
  // static const String id = 'colors-slide';
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
  // bool showTimer = false;
  // ColorsSlideDifficulty currentDifficulty = ColorsSlideDifficulty.threeByThree;
  // ColorsSlideDifficulty oldDifficulty = ColorsSlideDifficulty.threeByThree;
  Controller cont = Controller();
  List<GamePiece> pieces = [];
  // String size = '3x3';
  String timerStatus = '';

  late StreamSubscription _eventStream;

  @override
  void initState() {
    super.initState();
    print('cs init');

    setState(() {
      pieces = [];
    });

    // _eventStream = Controller.listen(onAction);
    _eventStream = cont.listen(onAction);

    cont.start(
      context,
    );

    // Timer(
    //   const Duration(milliseconds: 100),
    //   () {
    //     // Controller.gridSize = Controller.initGridSize;
    //     // cont.gridSize = cont.initGridSize;
    //     // cont.restart(context);
    //   },
    // );
  }

  void onAction(dynamic data) {
    setState(() {
      // pieces = Controller.pieces;
      pieces = cont.pieces;
    });
  }

  void checkTimer(bool showTimer) {
    if (showTimer != showTimer) {
      Timer(const Duration(milliseconds: 100), () {
        cont.restart(context);
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
      content: BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
        builder: (context, state) {
          if (state.resetColors) {
            cont.restart(context);
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
                //   children: state.showTimer
                //       ? [
                //           const CSSize(),
                //           const Score(
                //             // pieces: pieces,
                //             // cont: cont,
                //           ),
                //           CSTimer(
                //             timer: state.showTimer,
                //             timerStatus: timerStatus,
                //           ),
                //         ]
                //       : [
                //           const CSSize(),
                //           const Score(
                //             // pieces: pieces,
                //             // cont: cont,
                //           ),
                //         ],
                // ),
                GameBoard(
                  pieces: pieces,
                  cont: cont,
                ),
                const SizedBox(),
                const SizedBox(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
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
                            cont.restart(context);
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
        child: IconButton(
          icon: Icon(
            Icons.settings_backup_restore_rounded,
            color: Theme.of(context).colorScheme.background,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              pieces = [];
              timerStatus = 'reset';
            });
            cont.restart(context);
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
