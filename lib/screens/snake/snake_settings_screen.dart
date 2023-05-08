import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class SnakeSettingsScreen extends StatefulWidget {
  static const String routeName = '/snake-settings';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SnakeSettingsScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SnakeSettingsScreen({
    Key? key,
  }) : super(key: key);

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Snake Settings',
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
              'Change your difficulty for more fun. As a heads up, changing any of the settings here will reset your game.',
              false,
              TextAlign.left,
              'GLHF',
            ),
          )
        ],
      ),
      body: BlocBuilder<SnakeBloc, SnakeState>(
        builder: (context, state) {
          if (state.snakeStatus != ColorsSlideStatus.error) {
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
                                      // snakeStatus: SnakeStatus.reset,
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
                                      snakeSpeed: SnakeSpeed.slow,
                                      // snakeStatus: SnakeStatus.reset,
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
                                      snakeSpeed: SnakeSpeed.slow,
                                      // snakeStatus: SnakeStatus.reset,
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
                                      snakeSpeed: SnakeSpeed.slow,
                                      // snakeStatus: SnakeStatus.reset,
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
                                      snakeSpeed: SnakeSpeed.slow,
                                      // snakeStatus: SnakeStatus.reset,
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
                            value: SnakeSpeed.why,
                            groupValue: state.snakeSpeed,
                            onChanged: (_) {
                              context.read<SnakeBloc>().add(
                                    const UpdateSnakeSpeed(
                                      snakeSpeed: SnakeSpeed.slow,
                                      // snakeStatus: SnakeStatus.reset,
                                    ),
                                  );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'why',
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
