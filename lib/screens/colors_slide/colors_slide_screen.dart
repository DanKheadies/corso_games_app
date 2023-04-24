import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
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
  ColorsController cont = ColorsController();
  StopWatchTimer csTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();
    // print('colors init');
    csTimer.onStartTimer();
  }

  @override
  void dispose() async {
    super.dispose();
    await csTimer.dispose();
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
            context.read<TimerCubit>().resetTimer(TimerGame.colorsSlide);
          }

          if (state.colorsStatus != ColorsSlideStatus.error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CSSize(),
                    const ColorsScore(),
                    if (state.showColorsTimer)
                      BlocBuilder<TimerCubit, TimerState>(
                        builder: (context, state) {
                          // print('daco: ${state.colorsSlideDuration}');
                          return VisibilityDetector(
                            key: const Key('colors-slide-timer'),
                            onVisibilityChanged: (visInfo) {
                              if (visInfo.visibleBounds == Rect.zero) {
                                // should pause, i.e. timer not showing / present
                                print('not visible, stop timer');
                                csTimer.onStopTimer();
                                context.read<TimerCubit>().cacheTime(
                                      TimerGame.colorsSlide,
                                    );
                                print('cache: ${state.colorsSlideCache}');
                              } else {
                                // should start timer b/c we're showing timer
                                if (!csTimer.isRunning) {
                                  print('visible, start timer');
                                  csTimer.onStartTimer();
                                }
                              }
                            },
                            child: StreamBuilder(
                              stream: csTimer.secondTime,
                              initialData: 0,
                              builder: (context, snap) {
                                // Checks (to be removed)
                                print('tick');
                                print('seconds: ${DateTime.now().second}');
                                print('millis: ${DateTime.now().millisecond}');
                                var value = snap.data;

                                // Update active
                                context.read<TimerCubit>().updateTime(
                                      TimerGame.colorsSlide,
                                      value! + state.colorsSlideCache!,
                                    );
                                print('updated active');

                                // Init w/ stored data
                                // if (value == 0 && state.colorsSlideCache != 0) {
                                //   // fresh start but add duration to value
                                //   // value = 0
                                //   // cache = 10
                                //   print('init; adding cache to value');
                                //   value = state.colorsSlideCache;
                                //   // active = 10
                                // } else if (
                                //     // value is less than duration
                                //     // value = 1
                                //     // cache = 10
                                //     value < state.colorsSlideCache!) {
                                //   // add duration & value
                                //   print('adding');
                                //   value += state.colorsSlideCache!;
                                //   // active = 11
                                // } else if (value >= state.colorsSlideCache!) {
                                //   // value caught up, so keep duration = to value
                                //   print('updating');
                                //   context.read<TimerCubit>().updateTime(
                                //         TimerGame.colorsSlide,
                                //         value,
                                //       );
                                // }
                                // print('state: ${state.colorsSlideDuration}');
                                // if (state.colorsSlideDuration != 0) {
                                //   print('dur: ${state.colorsSlideDuration}');
                                //   value = value! + state.colorsSlideDuration!;
                                //   // context.read<TimerCubit>().cacheTime(
                                //   //       TimerGame.colorsSlide,
                                //   //       value,
                                //   //     );
                                // }

                                // return Text(value.toString());
                                return Column(
                                  children: [
                                    Text('value: $value'),
                                    Text('activ: ${state.colorsSlideActive}'),
                                    Text('cache: ${state.colorsSlideCache}'),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
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
      screenFunction: (String string) {
        if (string == 'drawerOpen') {
          print('open');
          csTimer.onStopTimer();
        } else if (string == 'drawerClose') {
          print('close');
          csTimer.onStartTimer();
        } else if (string == 'drawerNavigate') {
          print('nav');
          csTimer.onStopTimer();
        }
      },
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
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
                              state.colorsSize,
                              state.colorsPieces,
                              state.colorsIndexMap,
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
            // TODO: for testing misc-bloc stuff
            // BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
            //   builder: (context, state) {
            //     if (state.colorsStatus != ColorsSlideStatus.error) {
            //       return IconButton(
            //         tooltip: 'Share',
            //         icon: Icon(
            //           Icons.ios_share_outlined,
            //           color: Theme.of(context).colorScheme.background,
            //           size: 30,
            //         ),
            //         onPressed: () {
            //           // await HydratedBloc.storage.clear();
            //           // context.read<ColorsSlideBloc>().add(
            //           //       UpdateColorsSlideScore(
            //           //         increaseAmount: 1,
            //           //         reset: false,
            //           //       ),
            //           //     );
            //         },
            //       );
            //     } else {
            //       return IconButton(
            //         icon: Icon(
            //           Icons.warning,
            //           color: Theme.of(context).colorScheme.background,
            //           size: 30,
            //         ),
            //         onPressed: () {
            //           ScaffoldMessenger.of(context).showSnackBar(
            //             SnackBar(
            //               content: Text(
            //                 'There is an error.',
            //                 style: TextStyle(
            //                   color: Theme.of(context).colorScheme.surface,
            //                 ),
            //               ),
            //               duration: const Duration(seconds: 3),
            //             ),
            //           );
            //         },
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
      floatingButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
          builder: (context, state) {
            if (state.colorsStatus != ColorsSlideStatus.error) {
              return IconButton(
                icon: Icon(
                  Icons.settings_backup_restore_rounded,
                  color: Theme.of(context).colorScheme.background,
                  size: 30,
                ),
                onPressed: () {
                  csTimer.onResetTimer();
                  context.read<TimerCubit>().resetTimer(TimerGame.colorsSlide);
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
