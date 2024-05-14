import 'dart:async';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ElSettingsScreen extends StatefulWidget {
  const ElSettingsScreen({super.key});

  @override
  State<ElSettingsScreen> createState() => _ElSettingsScreenState();
}

class _ElSettingsScreenState extends State<ElSettingsScreen> {
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
      screen: 'El Word Settings',
      bottomBar: const SizedBox(),
      infoDetails:
          'Change your difficulty for more fun. As a heads up, changing any of the settings here will reset your game.',
      infoTitle: 'Settings',
      nav: 'elWord',
      screenFunction: (_) {},
      child: BlocBuilder<ElWordBloc, ElWordState>(
        builder: (context, state) {
          if (state.status != ElWordStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<BrightnessCubit, Brightness>(
                    builder: (context, bright) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('difficulty'),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(15),
                            value: ElWordDifficulty.normal,
                            groupValue: state.difficulty,
                            onChanged: (_) {
                              context.read<ElWordBloc>().add(
                                    const UpdateElWordDifficulty(
                                      elDifficulty: ElWordDifficulty.normal,
                                    ),
                                  );
                              Timer(
                                Duration.zero,
                                () {
                                  Word.resetGuesses();
                                  context.read<ElWordBloc>().add(
                                        ResetElWord(),
                                      );
                                },
                              );
                            },
                            style: _neumorphRadioStyle(bright),
                            child: const Text(
                              'Normal',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          NeumorphicRadio(
                            padding: const EdgeInsets.all(15),
                            value: ElWordDifficulty.hard,
                            groupValue: state.difficulty,
                            onChanged: (_) {
                              context.read<ElWordBloc>().add(
                                    const UpdateElWordDifficulty(
                                      elDifficulty: ElWordDifficulty.hard,
                                    ),
                                  );
                              Timer(
                                Duration.zero,
                                () {
                                  Word.resetGuesses();
                                  context.read<ElWordBloc>().add(
                                        ResetElWord(),
                                      );
                                },
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
