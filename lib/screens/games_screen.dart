import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Corso Games',
      bottomBar: const SizedBox(),
      infoTitle: 'Corso Rules',
      infoDetails:
          'Enjoy the games. If you have a problem, send an email to support@holisticgaming.com.',
      screenFunction: (_) {},
      showGLHF: true,
      child: GridView.count(
        padding: const EdgeInsets.all(25),
        mainAxisSpacing: 10,
        crossAxisSpacing: 25,
        crossAxisCount: 2,
        children: [
          GameButton(
            isIconic: true,
            icon: Icons.animation,
            title: 'Ball Bounce',
            onPress: () => context.goNamed('ballBounce'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.filter_list,
            title: 'Breakup',
            onPress: () => context.goNamed('breakup'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.blur_linear_rounded,
            title: 'Colors Slide',
            onPress: () => context.goNamed('colorsSlide'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.run_circle,
            title: 'Dino Dash',
            onPress: () => context.goNamed('dinoDash'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.abc,
            title: 'El Word',
            onPress: () => context.goNamed('elWord'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.hexagon_outlined,
            title: 'Honeygram',
            onPress: () => context.goNamed('honeygram'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.flag_rounded,
            title: 'Minesweeper',
            onPress: () => context.goNamed('minesweeper'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.numbers,
            title: 'NAD',
            onPress: () => context.goNamed('numbersAndDraggin'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.drag_indicator,
            title: 'PAD',
            onPress: () => context.goNamed('puzzlesAndDraggin'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.view_comfortable,
            title: 'Slide to Slide',
            onPress: () => context.goNamed('slideToSlide'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.all_inclusive,
            title: 'Snake',
            onPress: () => context.goNamed('snake'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.stacked_bar_chart,
            title: 'Solitare',
            onPress: () => context.goNamed('solitare'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.grain_rounded,
            title: 'Solo Noble',
            onPress: () => context.goNamed('soloNoble'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.stacked_bar_chart,
            title: 'Stack Stacks',
            onPress: () => context.goNamed('stackStacks'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.airline_stops,
            title: 'Tappy Bird',
            onPress: () => context.goNamed('tappyBird'),
          ),
          GameButton(
            isIconic: true,
            icon: Icons.tag,
            title: 'Tic Tac Toe',
            onPress: () => context.goNamed('ticTacToe'),
          ),
        ],
      ),
    );
  }
}
