import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/colors_slide/colors_slide_screen.dart';
import 'package:corso_games_app/screens/dino_run_screen.dart';
import 'package:corso_games_app/screens/minesweeper/minesweeper_screen.dart';
import 'package:corso_games_app/screens/nonograms_screen.dart';
import 'package:corso_games_app/screens/slide_to_slide_screen.dart';
import 'package:corso_games_app/widgets/game_button.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class GamesScreen extends StatelessWidget {
  static const String id = 'games';

  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // print('wX: $width');
    // print('h0: $height');
    // var padding = MediaQuery.of(context).viewPadding;
    // double height1 = height - padding.top - padding.bottom;
    // print('h1: $height1');
    // double height2 = height - padding.top;
    // print('h2: $height2');
    // double height3 = height - padding.top - kToolbarHeight;
    // print('h3: $height3');
    return ScreenWrapper(
      title: 'Games',
      infoTitle: 'Corso Games',
      infoDetails:
          'Enjoy the games, and if you have a problem, send an email to support@holisticgaming.com. \n\nGood luck, have fun!',
      backgroundOverride: Colors.transparent,
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
      screenFunction: (String _string) {},
      bottomBar: const BottomAppBar(),
    );
  }
}
