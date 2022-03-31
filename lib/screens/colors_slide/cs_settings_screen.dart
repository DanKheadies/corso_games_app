import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/widgets/screen_info.dart';

enum ColorsSlideDifficulty {
  tbd,
  easy,
  medium,
  hard,
  harder,
  wtf,
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
              '- Change your difficulty \n- Show the timer \n\nJust know, if you change any the difficulty, we\'ll reset your game. GLHF!',
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
                  'Easy',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                padding: const EdgeInsets.all(15),
                value: ColorsSlideDifficulty.easy,
                groupValue: _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
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
                value: ColorsSlideDifficulty.medium,
                groupValue: _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
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
                value: ColorsSlideDifficulty.hard,
                groupValue: _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
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
                value: ColorsSlideDifficulty.harder,
                groupValue: _difficulty,
                onChanged: (ColorsSlideDifficulty? diff) {
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
                value: ColorsSlideDifficulty.wtf,
                groupValue: _difficulty,
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
