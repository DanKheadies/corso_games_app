import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class MSSettingsScreen extends StatefulWidget {
  static const String routeName = '/minesweeper-settings';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const MSSettingsScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const MSSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MSSettingsScreen> createState() => _MSSettingsScreenState();
}

class _MSSettingsScreenState extends State<MSSettingsScreen> {
  NeumorphicRadioStyle _neumorphRadioStyle() {
    return NeumorphicRadioStyle(
      unselectedColor: Theme.of(context).scaffoldBackgroundColor,
      selectedDepth:
          MediaQuery.of(context).platformBrightness == Brightness.dark ? 1 : 4,
      unselectedDepth:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? -1
              : -4,
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
          'MS Settings',
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
      body: BlocBuilder<MinesweeperBloc, MinesweeperState>(
        builder: (context, state) {
          if (state.mineStatus != MinesweeperStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('timer'),
                      const SizedBox(height: 30),
                      NeumorphicSwitch(
                        style: NeumorphicSwitchStyle(
                          activeThumbColor:
                              Theme.of(context).colorScheme.tertiary,
                          activeTrackColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          inactiveThumbColor:
                              Theme.of(context).colorScheme.primary,
                          inactiveTrackColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                        value: state.showMineTimer,
                        onChanged: (value) {
                          context.read<MinesweeperBloc>().add(
                                ToggleMinesweeperTimer(),
                              );
                        },
                      ),
                    ],
                  ),
                  Column(
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
                                  mineDifficulty: MinesweeperDifficulty.easy,
                                ),
                              );
                        },
                        style: _neumorphRadioStyle(),
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
                                  mineDifficulty: MinesweeperDifficulty.medium,
                                ),
                              );
                        },
                        style: _neumorphRadioStyle(),
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
                                  mineDifficulty: MinesweeperDifficulty.hard,
                                ),
                              );
                        },
                        style: _neumorphRadioStyle(),
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
                                  mineDifficulty: MinesweeperDifficulty.harder,
                                ),
                              );
                        },
                        style: _neumorphRadioStyle(),
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
                        style: _neumorphRadioStyle(),
                        child: const Text(
                          'WTF',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
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
