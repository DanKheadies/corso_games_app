import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/widgets/widgets.dart';

enum ColorsSlideDifficulty {
  tbd,
  threeByThree,
  fourByFour,
  fiveByFive,
  sevenBySeven,
  tenByTen,
  yolo,
}

class CSSettingsScreen extends StatefulWidget {
  // static const String id = 'colors-slide-settings';
  static const String routeName = '/colors-slide-settings';
  static Route route({
    required ColorsSlideDifficulty difficulty,
    required bool timer,
  }) {
    return MaterialPageRoute(
      builder: (_) => CSSettingsScreen(
        difficulty: difficulty,
        timer: timer,
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  final bool timer;
  final ColorsSlideDifficulty difficulty;

  const CSSettingsScreen({
    Key? key,
    required this.timer,
    required this.difficulty,
  }) : super(key: key);

  @override
  State<CSSettingsScreen> createState() => _CSSettingsScreenState();
}

class _CSSettingsScreenState extends State<CSSettingsScreen> {
  bool argsTimer = false;
  bool showTimer = false;
  ColorsSlideDifficulty? _difficulty = ColorsSlideDifficulty.tbd;

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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, {
            'difficulty': _difficulty == ColorsSlideDifficulty.tbd
                // ? args['difficulty'] as ColorsSlideDifficulty
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
                  const Text('size'),
                  NeumorphicRadio(
                    padding: const EdgeInsets.all(15),
                    value: ColorsSlideDifficulty.threeByThree,
                    groupValue: _difficulty == ColorsSlideDifficulty.tbd
                        // ? args['difficulty'] as ColorsSlideDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (ColorsSlideDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
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
                    groupValue: _difficulty == ColorsSlideDifficulty.tbd
                        // ? args['difficulty'] as ColorsSlideDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (ColorsSlideDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
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
                    groupValue: _difficulty == ColorsSlideDifficulty.tbd
                        // ? args['difficulty'] as ColorsSlideDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (ColorsSlideDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
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
                    groupValue: _difficulty == ColorsSlideDifficulty.tbd
                        // ? args['difficulty'] as ColorsSlideDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (ColorsSlideDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
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
                    groupValue: _difficulty == ColorsSlideDifficulty.tbd
                        // ? args['difficulty'] as ColorsSlideDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (ColorsSlideDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
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
                    groupValue: _difficulty == ColorsSlideDifficulty.tbd
                        // ? args['difficulty'] as ColorsSlideDifficulty
                        ? widget.difficulty
                        : _difficulty,
                    onChanged: (ColorsSlideDifficulty? diff) {
                      setState(() {
                        _difficulty = diff;
                      });
                    },
                    style: _neumorphRadioStyle(),
                    child: const Text(
                      'YOLO',
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
