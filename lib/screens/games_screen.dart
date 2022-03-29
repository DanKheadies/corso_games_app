import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/colors_slide_screen.dart';
import 'package:corso_games_app/screens/dino_run_screen.dart';
import 'package:corso_games_app/screens/minesweeper_screen.dart';
import 'package:corso_games_app/screens/nonograms_screen.dart';
import 'package:corso_games_app/screens/slide_to_slide_screen.dart';
import 'package:corso_games_app/widgets/game_button.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class GamesScreen extends StatelessWidget {
  static const String id = 'games';

  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Games',
      infoTitle: 'Corso Games',
      infoDetails:
          'Enjoy the games, and if you have a problem, send an email to support@holisticgaming.com. \n\nGood luck, have fun!',
      content: GridView.count(
        padding: const EdgeInsets.all(25),
        mainAxisSpacing: 10,
        crossAxisSpacing: 25,
        crossAxisCount: 2,
        children: [
          GameButton(
            icon: Icons.blur_linear_rounded,
            title: 'Colors Slide',
            onPress: () => Navigator.pushNamed(
              context,
              ColorsSlideScreen.id,
            ),
          ),
          GameButton(
            icon: Icons.run_circle,
            title: 'Dino Run',
            onPress: () => Navigator.pushNamed(
              context,
              DinoRunScreen.id,
            ),
          ),
          GameButton(
            icon: Icons.flag_rounded,
            title: 'Minesweeper',
            onPress: () => Navigator.pushNamed(
              context,
              MinesweeperScreen.id,
            ),
          ),
          GameButton(
            icon: Icons.pin_rounded,
            title: 'Nonograms',
            onPress: () => Navigator.pushNamed(
              context,
              NonogramsScreen.id,
            ),
          ),
          GameButton(
            icon: Icons.view_comfortable,
            title: 'Slide to Slide',
            onPress: () => Navigator.pushNamed(
              context,
              SlideToSlideScreen.id,
            ),
          ),
        ],
      ),
      bottomBar: const BottomAppBar(),
    );
  }
}
