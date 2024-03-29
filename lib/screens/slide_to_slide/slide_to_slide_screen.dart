import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class SlideToSlideScreen extends StatelessWidget {
  // static const String id = 'slide-to-slide';
  static const String routeName = '/slide-to-slide';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SlideToSlideScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SlideToSlideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Slide to Slide',
      infoTitle: 'Slide to Slide',
      infoDetails:
          'Re-arrange the tiles by moving them into the empty spot. Get the numbers to read 1-16, left to right.',
      backgroundOverride: Colors.transparent,
      content: const PuzzleScreen(),
      screenFunction: (String string) {},
      bottomBar: const SizedBox(),
    );
  }
}
