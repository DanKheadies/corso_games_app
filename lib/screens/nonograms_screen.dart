import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/widgets.dart';

class NonogramsScreen extends StatelessWidget {
  static const String id = 'nonograms';

  const NonogramsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Nonograms',
      infoTitle: 'Nonograms',
      infoDetails:
          'Soon you\'ll be able to maths the numbers to make shapes and art.',
      button: 'Oh Boy',
      backgroundOverride: Colors.transparent,
      content: const ComingSoon(),
      screenFunction: (String _string) {},
      bottomBar: const BottomAppBar(),
    );
  }
}
