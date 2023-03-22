import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/widgets/widgets.dart';

enum MinesweeperDifficulty {
  tbd,
  easy,
  medium,
  hard,
  harder,
  wtf,
}

class MSSettingsScreen extends StatefulWidget {
  // static const String id = 'minesweeper-settings';
  static const String routeName = '/minesweeper-settings';
  static Route route({
    required MinesweeperDifficulty difficulty,
    required bool timer,
  }) {
    return MaterialPageRoute(
      builder: (_) => MSSettingsScreen(
        difficulty: difficulty,
        timer: timer,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final bool timer;
  final MinesweeperDifficulty difficulty;

  const MSSettingsScreen({
    Key? key,
    required this.timer,
    required this.difficulty,
  }) : super(key: key);

  @override
  State<MSSettingsScreen> createState() => _MSSettingsScreenState();
}

class _MSSettingsScreenState extends State<MSSettingsScreen> {
  bool argsTimer = false;
  bool showTimer = false;
  MinesweeperDifficulty? _difficulty = MinesweeperDifficulty.tbd;

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
    if (argsTimer != widget.timer) {
      setState(() {
        argsTimer = widget.timer;
      });
    }

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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, {
            'difficulty': _difficulty == MinesweeperDifficulty.tbd
                // ? args['difficulty'] as MinesweeperDifficulty
                ? widget.difficulty
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
                      activeThumbColor: Theme.of(context).colorScheme.tertiary,
                      activeTrackColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      inactiveThumbColor: Theme.of(context).colorScheme.primary,
                      inactiveTrackColor:
                          Theme.of(context).scaffoldBackgroundColor,
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
                    padding: const EdgeInsets.all(15),
                    value: MinesweeperDifficulty.easy,
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        // ? args['difficulty'] as MinesweeperDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
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
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        // ? args['difficulty'] as MinesweeperDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
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
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        // ? args['difficulty'] as MinesweeperDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
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
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        // ? args['difficulty'] as MinesweeperDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
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
                    groupValue: _difficulty == MinesweeperDifficulty.tbd
                        // ? args['difficulty'] as MinesweeperDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (MinesweeperDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
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
        ),
      ),
    );
  }
}
