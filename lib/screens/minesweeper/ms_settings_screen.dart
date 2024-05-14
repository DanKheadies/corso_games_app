import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MSSettingsScreen extends StatefulWidget {
  const MSSettingsScreen({super.key});

  @override
  State<MSSettingsScreen> createState() => _MSSettingsScreenState();
}

class _MSSettingsScreenState extends State<MSSettingsScreen> {
  NeumorphicRadioStyle _neumorphRadioStyle(Brightness state) {
    return NeumorphicRadioStyle(
      unselectedColor: Theme.of(context).scaffoldBackgroundColor,
      selectedDepth: state == Brightness.dark ? 1 : 4,
      unselectedDepth: state == Brightness.dark ? -1 : -4,
      intensity: 2.5,
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Minesweeper Settings',
      bottomBar: const SizedBox(),
      hasAppBar: true,
      hasDrawer: false,
      infoTitle: 'MS Settings',
      infoDetails:
          'Change your difficulty for more fun. As a heads up, changing any of the settings here will reset your game.',
      screenFunction: (_) {},
      nav: 'minesweeper',
      child: BlocBuilder<MinesweeperBloc, MinesweeperState>(
        builder: (context, state) {
          if (state.mineStatus != MinesweeperStatus.error) {
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
                  //       value: state.showMineTimer,
                  //       onChanged: (value) {
                  //         print(
                  //             'changing the timer w/ current status ${state.mineTimerStatus}');
                  //         context.read<MinesweeperBloc>().add(
                  //               const ToggleMinesweeperTimer(
                  //                 mineTimerStatus:
                  //                     MinesweeperTimerStatus.resume,
                  //               ),
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
                          const Text('difficulty'),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(15),
                            value: MinesweeperDifficulty.easy,
                            groupValue: state.mineDifficulty,
                            onChanged: (_) {
                              context.read<MinesweeperBloc>().add(
                                    const UpdateMinesweeperDifficulty(
                                      resetMinesweeper: true,
                                      mineDifficulty:
                                          MinesweeperDifficulty.easy,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'Easy',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(15),
                            value: MinesweeperDifficulty.medium,
                            groupValue: state.mineDifficulty,
                            onChanged: (_) {
                              context.read<MinesweeperBloc>().add(
                                    const UpdateMinesweeperDifficulty(
                                      resetMinesweeper: true,
                                      mineDifficulty:
                                          MinesweeperDifficulty.medium,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'Medium',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: MinesweeperDifficulty.hard,
                            groupValue: state.mineDifficulty,
                            onChanged: (_) {
                              context.read<MinesweeperBloc>().add(
                                    const UpdateMinesweeperDifficulty(
                                      resetMinesweeper: true,
                                      mineDifficulty:
                                          MinesweeperDifficulty.hard,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'Hard',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: MinesweeperDifficulty.harder,
                            groupValue: state.mineDifficulty,
                            onChanged: (_) {
                              context.read<MinesweeperBloc>().add(
                                    const UpdateMinesweeperDifficulty(
                                      resetMinesweeper: true,
                                      mineDifficulty:
                                          MinesweeperDifficulty.harder,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'Harder',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: MinesweeperDifficulty.wtf,
                            groupValue: state.mineDifficulty,
                            onChanged: (_) {
                              context.read<MinesweeperBloc>().add(
                                    const UpdateMinesweeperDifficulty(
                                      resetMinesweeper: true,
                                      mineDifficulty: MinesweeperDifficulty.wtf,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'WTF',
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
