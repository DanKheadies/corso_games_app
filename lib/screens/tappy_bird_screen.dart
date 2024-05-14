import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TappyBirdScreen extends StatefulWidget {
  const TappyBirdScreen({super.key});

  @override
  State<TappyBirdScreen> createState() => _TappyBirdScreenState();
}

class _TappyBirdScreenState extends State<TappyBirdScreen> {
  bool hasLeft = false;
  bool isLeaving = false;
  bool pauseGame = false;

  @override
  void didChangeDependencies() {
    hasLeft = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print('build tb screen');
    double height = MediaQuery.of(context).size.height;

    return ScreenWrapper(
      screen: 'Tappy Bird',
      bottomBar: const SizedBox(),
      infoTitle: 'Tappy Bird',
      infoDetails: 'Tap to stay a float. Or don\'t..',
      screenFunction: (String string) {
        if (!hasLeft) {
          if (string == 'drawerOpen') {
            // print('open');
            setState(() {
              pauseGame = true;
            });
          } else if (string == 'drawerClose') {
            // print('close');
            setState(() {
              pauseGame = false;
            });
          } else if (string == 'drawerNavigate') {
            // print('navigating');
            setState(() {
              isLeaving = true;
            });
          }
        }
      },
      child: BirdGame(
        height: height,
        isLeaving: isLeaving,
        pauseGame: pauseGame,
      ),
    );
  }
}
