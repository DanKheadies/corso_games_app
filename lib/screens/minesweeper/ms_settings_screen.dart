import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/widgets/screen_info.dart';

enum MinesweeperDifficulty {
  tbd,
  easy,
  medium,
  hard,
  harder,
  wtf,
}

class MSSettingsScreen extends StatefulWidget {
  static const String id = 'minesweeper-settings';

  const MSSettingsScreen({Key? key}) : super(key: key);

  @override
  State<MSSettingsScreen> createState() => _MSSettingsScreenState();
}

class _MSSettingsScreenState extends State<MSSettingsScreen> {
  bool argsTimer = false;
  bool showTimer = false;
  MinesweeperDifficulty? _difficulty = MinesweeperDifficulty.tbd;

  NeumorphicRadioStyle _neumorphRadioStyle() {
    return NeumorphicRadioStyle(
      unselectedColor: Theme.of(context).colorScheme.secondary,
      selectedDepth: 4,
      unselectedDepth: -4,
      intensity: 2.5,
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        showTimer = argsTimer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    setState(() {
      argsTimer = args['timer'];
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text('MS Settings'),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showScreenInfo(
              context,
              'Settings',
              '''-Change your difficulty \n
- (Soon) Show timer \n\n
Heads up: changing any of the settings here will reset your game. \n\n
GLHF!''',
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, {
            'difficulty': _difficulty == MinesweeperDifficulty.tbd
                ? args['difficulty'] as MinesweeperDifficulty
                : _difficulty,
            'timer': showTimer,
          });
          return true;
        },
        child: Center(
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
                      activeThumbColor: Theme.of(context).colorScheme.primary,
                      activeTrackColor: Theme.of(context).colorScheme.secondary,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.secondary,
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.secondary,
                    ),
                    value: showTimer,
                    onChanged: (value) {
                      setState(() {
                        showTimer = !showTimer;
                      });
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('difficulty'),
                  NeumorphicRadio(
                    child: const Text(
                      'Easy',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                    value: MinesweeperDifficulty.easy,
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        ? args['difficulty'] as MinesweeperDifficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
                  ),
                  NeumorphicRadio(
                    child: const Text(
                      'Medium',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                    value: MinesweeperDifficulty.medium,
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        ? args['difficulty'] as MinesweeperDifficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
                  ),
                  NeumorphicRadio(
                    child: const Text(
                      'Hard',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    value: MinesweeperDifficulty.hard,
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        ? args['difficulty'] as MinesweeperDifficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
                  ),
                  NeumorphicRadio(
                    child: const Text(
                      'Harder',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    value: MinesweeperDifficulty.harder,
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        ? args['difficulty'] as MinesweeperDifficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
                  ),
                  NeumorphicRadio(
                    child: const Text(
                      'WTF',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    value: MinesweeperDifficulty.wtf,
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        ? args['difficulty'] as MinesweeperDifficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
