import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/models/colors/cs_settings_arguments.dart';
import 'package:corso_games_app/widgets/screen_info.dart';

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
  static const String id = 'colors-slide-settings';

  const CSSettingsScreen({Key? key}) : super(key: key);

  @override
  State<CSSettingsScreen> createState() => _CSSettingsScreenState();
}

class _CSSettingsScreenState extends State<CSSettingsScreen> {
  ColorsSlideDifficulty? _difficulty = ColorsSlideDifficulty.tbd;

  NeumorphicRadioStyle _neumorphRadioStyle() {
    return NeumorphicRadioStyle(
      // selectedColor: Theme.of(context).colorScheme.primary,
      unselectedColor: Theme.of(context).colorScheme.secondary,
      selectedDepth: 4,
      unselectedDepth: -4,
      intensity: 2.5,
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CSSettingsArguments;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text('CS Settings'),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showScreenInfo(
              context,
              'Settings',
              '''- Change your difficulty \n
                 - (Soon) Show timer \n\n
                 
                 Just know, if you select any difficulty, we\'ll reset your game. \n\n
                 
                 GLHF!''',
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _difficulty);
          return true;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NeumorphicRadio(
                child: const Text(
                  '3x3',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(15),
                value: ColorsSlideDifficulty.threeByThree,
                // groupValue: args.difficulty,
                groupValue: _difficulty == ColorsSlideDifficulty.tbd
                    ? args.difficulty
                    : _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
                  setState(() {
                    _difficulty = diff;
                  });
                },
                style: _neumorphRadioStyle(),
              ),
              NeumorphicRadio(
                child: const Text(
                  '4x4',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(15),
                value: ColorsSlideDifficulty.fourByFour,
                groupValue: _difficulty == ColorsSlideDifficulty.tbd
                    ? args.difficulty
                    : _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
                  setState(() {
                    _difficulty = diff;
                  });
                },
                style: _neumorphRadioStyle(),
              ),
              NeumorphicRadio(
                child: const Text(
                  '5x5',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                value: ColorsSlideDifficulty.fiveByFive,
                groupValue: _difficulty == ColorsSlideDifficulty.tbd
                    ? args.difficulty
                    : _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
                  setState(() {
                    _difficulty = diff;
                  });
                },
                style: _neumorphRadioStyle(),
              ),
              NeumorphicRadio(
                child: const Text(
                  '7x7',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                value: ColorsSlideDifficulty.sevenBySeven,
                groupValue: _difficulty == ColorsSlideDifficulty.tbd
                    ? args.difficulty
                    : _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
                  setState(() {
                    _difficulty = diff;
                  });
                },
                style: _neumorphRadioStyle(),
              ),
              NeumorphicRadio(
                child: const Text(
                  '10x10',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                value: ColorsSlideDifficulty.tenByTen,
                groupValue: _difficulty == ColorsSlideDifficulty.tbd
                    ? args.difficulty
                    : _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
                  setState(() {
                    _difficulty = diff;
                  });
                },
                style: _neumorphRadioStyle(),
              ),
              NeumorphicRadio(
                child: const Text(
                  'YOLO',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                value: ColorsSlideDifficulty.yolo,
                groupValue: _difficulty == ColorsSlideDifficulty.tbd
                    ? args.difficulty
                    : _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
                  setState(() {
                    _difficulty = diff;
                  });
                },
                style: _neumorphRadioStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
