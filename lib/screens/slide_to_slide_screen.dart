import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/coming_soon.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class SlideToSlideScreen extends StatelessWidget {
  static const String id = 'slide-to-slide';

  const SlideToSlideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Slide to Slide',
      infoTitle: 'Slide to Slide',
      infoDetails: 'Good luck, have fun!',
      backgroundOverride: Colors.transparent,
      content: const ComingSoon(),
      screenFunction: (String _string) {},
      bottomBar: const BottomAppBar(),
    );
  }
}
