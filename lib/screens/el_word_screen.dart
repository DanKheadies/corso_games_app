import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/coming_soon.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class ElWordScreen extends StatelessWidget {
  static const String id = 'el-word';

  const ElWordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'El Word',
      infoTitle: 'El Word',
      infoDetails: 'Good luck, have fun!',
      backgroundOverride: Colors.transparent,
      content: const ComingSoon(),
      screenFunction: (String _string) {},
      bottomBar: const BottomAppBar(),
    );
  }
}