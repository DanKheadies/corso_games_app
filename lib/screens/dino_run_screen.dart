import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/coming_soon.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class DinoRunScreen extends StatelessWidget {
  static const String id = 'dino-run';

  const DinoRunScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(
      title: 'Dino Run',
      infoTitle: 'Dino Run',
      infoDetails: 'Good luck, have fun!',
      content: ComingSoon(),
      bottomBar: BottomAppBar(),
    );
  }
}
