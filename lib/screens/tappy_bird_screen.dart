import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TappyBirdScreen extends StatefulWidget {
  const TappyBirdScreen({super.key});

  @override
  State<TappyBirdScreen> createState() => _TappyBirdScreenState();
}

class _TappyBirdScreenState extends State<TappyBirdScreen> {
  bool hasLeft = false;
  bool pauseGame = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ScreenWrapper(
      screen: 'Tappy Bird',
      bottomBar: const SizedBox(),
      infoTitle: 'Tappy Bird',
      infoDetails: 'Tap to stay a float. Or don\'t..',
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
      child: BirdGame(
        height: height,
        isLeaving: hasLeft,
        pauseGame: pauseGame,
      ),
    );
  }
}
