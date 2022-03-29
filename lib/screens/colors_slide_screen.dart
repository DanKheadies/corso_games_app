import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/colors_slide/controller.dart';
import 'package:corso_games_app/widgets/colors_slide/game_board.dart';
import 'package:corso_games_app/widgets/colors_slide/score.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class ColorsSlideScreen extends StatelessWidget {
  static const String id = 'colors-slide';

  const ColorsSlideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Colors Slide',
      infoTitle: 'Colors Slide',
      infoDetails: 'Good luck, have fun!',
      children: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ScoreView(),
          const GameBoard(),
          Container(
            height: 64,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text('Yolo'),
          ),
        ],
      ),
    );
  }
}
