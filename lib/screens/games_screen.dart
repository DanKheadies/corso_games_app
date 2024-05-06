import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GamesScreen extends StatelessWidget {
  static const String routeName = '/games';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const GamesScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Corso Games',
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
            isIconic: true,
            icon: Icons.blur_linear_rounded,
            title: 'Colors Slide',
            onPress: () => Navigator.pushNamed(
              context,
              ColorsSlideScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.run_circle,
            title: 'Dino Dash',
            onPress: () => Navigator.pushNamed(
              context,
              DinoRunScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.abc,
            title: 'El Word',
            onPress: () => Navigator.pushNamed(
              context,
              ElWordScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.flag_rounded,
            title: 'Minesweeper',
            onPress: () => Navigator.pushNamed(
              context,
              MinesweeperScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.numbers,
            title: 'NAD',
            onPress: () => Navigator.pushNamed(
              context,
              NumbersAndDragginScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.drag_indicator,
            title: 'PAD',
            onPress: () => Navigator.pushNamed(
              context,
              PuzzlesAndDragginScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.view_comfortable,
            title: 'Slide to Slide',
            onPress: () => Navigator.pushNamed(
              context,
              SlideToSlideScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.all_inclusive,
            title: 'Snake',
            onPress: () => Navigator.pushNamed(
              context,
              SnakeScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.stacked_bar_chart,
            title: 'Solitare',
            onPress: () => Navigator.pushNamed(
              context,
              SolitareScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.grain_rounded,
            title: 'Solo Noble',
            onPress: () => Navigator.pushNamed(
              context,
              SoloNobleScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.airline_stops,
            title: 'Tappy Bird',
            onPress: () => Navigator.pushNamed(
              context,
              TappyBirdScreen.routeName,
            ),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.tag,
            title: 'Tic Tac Toe',
            onPress: () => Navigator.pushNamed(
              context,
              TicTacToeScreen.routeName,
            ),
          ),
        ],
      ),
      screenFunction: (String string) {},
      bottomBar: const SizedBox(),
    );
  }
}
