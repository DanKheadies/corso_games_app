import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class GamesScreen extends StatelessWidget {
  static const String id = 'games';

  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Games',
      infoTitle: 'Corso Rules',
      infoDetails:
          'Enjoy the games. If you have a problem, send an email to support@holisticgaming.com.',
      showGLHF: true,
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
            title: 'Dino Dash',
            onPress: () => Navigator.pushNamed(
              context,
              DinoRunScreen.id,
            ),
          ),
          GameButton(
            icon: Icons.abc,
            title: 'El Word',
            onPress: () => Navigator.pushNamed(
              context,
              ElWordScreen.id,
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
            icon: Icons.drag_indicator,
            title: 'PAD',
            onPress: () => Navigator.pushNamed(
              context,
              PuzzlesAndDragginScreen.id,
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
          GameButton(
            icon: Icons.stacked_bar_chart,
            title: 'Solitare',
            onPress: () => Navigator.pushNamed(
              context,
              SolitareScreen.id,
            ),
          ),
          GameButton(
            icon: Icons.tag,
            title: 'Tic Tac Toe',
            onPress: () => Navigator.pushNamed(
              context,
              TicTacToeScreen.id,
            ),
          ),
        ],
      ),
      screenFunction: (String _string) {},
      bottomBar: BottomAppBar(
        // TODO: remove this?
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
