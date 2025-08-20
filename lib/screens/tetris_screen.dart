import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TetrisScreen extends StatefulWidget {
  const TetrisScreen({super.key});

  @override
  State<TetrisScreen> createState() => _TetrisScreenState();
}

class _TetrisScreenState extends State<TetrisScreen> {
  bool hasLeft = false;
  bool pauseGame = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ScreenWrapper(
      screen: 'Tetris',
      bottomBar: const SizedBox(),
      infoTitle: 'Tetris',
      infoDetails:
          'Line up the squares to remove the squares. Stay alive as long as you can.',
      screenFunction: (String string) {
        if (string == 'drawerOpen') {
          setState(() {
            pauseGame = true;
          });
        } else if (string == 'drawerClose') {
          if (!hasLeft) {
            setState(() {
              pauseGame = false;
            });
          }
        } else if (string == 'drawerNavigate') {
          setState(() {
            hasLeft = true;
          });
        }
      },
      child: TetrisGameBoard(
        screenHeight: height,
      ),
    );
  }
}
