import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SlideToSlideScreen extends StatelessWidget {
  const SlideToSlideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Slide to Slide',
      bottomBar: const SizedBox(),
      infoTitle: 'Slide to Slide',
      infoDetails:
          'Re-arrange the tiles by moving them into the empty spot. Get the numbers to read 1-16, left to right.',
      screenFunction: (_) {},
      child: const PuzzleScreen(),
    );
  }
}
