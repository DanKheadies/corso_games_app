import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class CSSettingsScreen extends StatefulWidget {
  static const String routeName = '/colors-slide-settings';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const CSSettingsScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CSSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CSSettingsScreen> createState() => _CSSettingsScreenState();
}

class _CSSettingsScreenState extends State<CSSettingsScreen> {
  NeumorphicRadioStyle _neumorphRadioStyle(Brightness state) {
    return NeumorphicRadioStyle(
      unselectedColor: Theme.of(context).scaffoldBackgroundColor,
      selectedDepth: state == Brightness.dark ? 2 : 4,
      unselectedDepth: state == Brightness.dark ? -2 : -4,
      intensity: 2.5,
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'CS Settings',
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showScreenInfo(
              context,
              'Settings',
              '''
- Change your difficulty \n
- Show timer \n
Heads up: changing any of the settings here will reset your game.''',
              false,
              TextAlign.left,
              'GLHF',
            ),
          )
        ],
      ),
      body: BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
        builder: (context, state) {
          if (state.colorsStatus != ColorsSlideStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text('timer'),
                  //     const SizedBox(height: 30),
                  //     NeumorphicSwitch(
                  //       style: NeumorphicSwitchStyle(
                  //         activeThumbColor:
                  //             Theme.of(context).colorScheme.tertiary,
                  //         activeTrackColor:
                  //             Theme.of(context).scaffoldBackgroundColor,
                  //         inactiveThumbColor:
                  //             Theme.of(context).colorScheme.primary,
                  //         inactiveTrackColor:
                  //             Theme.of(context).scaffoldBackgroundColor,
                  //       ),
                  //       value: state.showColorsTimer,
                  //       onChanged: (value) {
                  //         context.read<ColorsSlideBloc>().add(
                  //               ToggleColorsSlideTimer(),
                  //             );
                  //       },
                  //     ),
                  //   ],
                  // ),
                  BlocBuilder<BrightnessCubit, Brightness>(
                    builder: (context, bright) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('size'),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(15),
                            value: ColorsSlideDifficulty.threeByThree,
                            groupValue: state.colorsDifficulty,
                            onChanged: (_) {
                              context.read<ColorsSlideBloc>().add(
                                    const UpdateColorsSlideDifficulty(
                                      resetColors: true,
                                      colorsDifficulty:
                                          ColorsSlideDifficulty.threeByThree,
                                      colorsSize: 3,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              '3x3',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(15),
                            value: ColorsSlideDifficulty.fourByFour,
                            groupValue: state.colorsDifficulty,
                            onChanged: (_) {
                              context.read<ColorsSlideBloc>().add(
                                    const UpdateColorsSlideDifficulty(
                                      resetColors: true,
                                      colorsDifficulty:
                                          ColorsSlideDifficulty.fourByFour,
                                      colorsSize: 4,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              '4x4',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: ColorsSlideDifficulty.fiveByFive,
                            groupValue: state.colorsDifficulty,
                            onChanged: (_) {
                              context.read<ColorsSlideBloc>().add(
                                    const UpdateColorsSlideDifficulty(
                                      resetColors: true,
                                      colorsDifficulty:
                                          ColorsSlideDifficulty.fiveByFive,
                                      colorsSize: 5,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              '5x5',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: ColorsSlideDifficulty.sevenBySeven,
                            groupValue: state.colorsDifficulty,
                            onChanged: (_) {
                              context.read<ColorsSlideBloc>().add(
                                    const UpdateColorsSlideDifficulty(
                                      resetColors: true,
                                      colorsDifficulty:
                                          ColorsSlideDifficulty.sevenBySeven,
                                      colorsSize: 7,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              '7x7',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: ColorsSlideDifficulty.tenByTen,
                            groupValue: state.colorsDifficulty,
                            onChanged: (_) {
                              context.read<ColorsSlideBloc>().add(
                                    const UpdateColorsSlideDifficulty(
                                      resetColors: true,
                                      colorsDifficulty:
                                          ColorsSlideDifficulty.tenByTen,
                                      colorsSize: 10,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              '10x10',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: ColorsSlideDifficulty.yolo,
                            groupValue: state.colorsDifficulty,
                            onChanged: (_) {
                              context.read<ColorsSlideBloc>().add(
                                    const UpdateColorsSlideDifficulty(
                                      resetColors: true,
                                      colorsDifficulty:
                                          ColorsSlideDifficulty.yolo,
                                      colorsSize: 0,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'YOLO',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(),
                        ],
                      );
                    },
                  ),
                ],
              ),
              // ),
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
