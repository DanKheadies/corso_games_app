import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SnakeSettingsScreen extends StatefulWidget {
  const SnakeSettingsScreen({super.key});

  @override
  State<SnakeSettingsScreen> createState() => _SnakeSettingsScreenState();
}

class _SnakeSettingsScreenState extends State<SnakeSettingsScreen> {
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
    return ScreenWrapper(
      screen: 'Snake Settings',
      bottomBar: const SizedBox(),
      hasAppBar: true,
      hasDrawer: false,
      infoTitle: 'Snake Settings',
      infoDetails:
          'Change your difficulty for more fun. As a heads up, changing any of the settings here will reset your game.',
      screenFunction: (_) {},
      nav: 'snake',
      child: BlocBuilder<SnakeBloc, SnakeState>(
        builder: (context, state) {
          if (state.snakeStatus != SnakeStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<BrightnessCubit, Brightness>(
                    builder: (context, bright) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('speed'),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(15),
                            value: SnakeSpeed.slow,
                            groupValue: state.snakeSpeed,
                            onChanged: (_) {
                              context.read<SnakeBloc>().add(
                                    const UpdateSnakeSpeed(
                                      snakeSpeed: SnakeSpeed.slow,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'slow',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(15),
                            value: SnakeSpeed.average,
                            groupValue: state.snakeSpeed,
                            onChanged: (_) {
                              context.read<SnakeBloc>().add(
                                    const UpdateSnakeSpeed(
                                      snakeSpeed: SnakeSpeed.average,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'average',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: SnakeSpeed.fast,
                            groupValue: state.snakeSpeed,
                            onChanged: (_) {
                              context.read<SnakeBloc>().add(
                                    const UpdateSnakeSpeed(
                                      snakeSpeed: SnakeSpeed.fast,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'fast',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: SnakeSpeed.faster,
                            groupValue: state.snakeSpeed,
                            onChanged: (_) {
                              context.read<SnakeBloc>().add(
                                    const UpdateSnakeSpeed(
                                      snakeSpeed: SnakeSpeed.faster,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'faster',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: SnakeSpeed.hell,
                            groupValue: state.snakeSpeed,
                            onChanged: (_) {
                              context.read<SnakeBloc>().add(
                                    const UpdateSnakeSpeed(
                                      snakeSpeed: SnakeSpeed.hell,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'hell',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(20),
                            value: SnakeSpeed.progression,
                            groupValue: state.snakeSpeed,
                            onChanged: (_) {
                              context.read<SnakeBloc>().add(
                                    const UpdateSnakeSpeed(
                                      snakeSpeed: SnakeSpeed.progression,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'progression',
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
