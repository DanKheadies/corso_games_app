import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/coming_soon.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class NonogramsScreen extends StatelessWidget {
  static const String id = 'nonograms';

  const NonogramsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(
      title: 'Nonograms',
      infoTitle: 'Nonograms',
      infoDetails: 'Good luck, have fun!',
      backgroundOverride: Colors.transparent,
      content: ComingSoon(),
      bottomBar: BottomAppBar(),
    );
  }
}
