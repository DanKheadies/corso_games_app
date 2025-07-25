import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BaebScreen extends StatefulWidget {
  const BaebScreen({super.key});

  @override
  State<BaebScreen> createState() => _BaebScreenState();
}

class _BaebScreenState extends State<BaebScreen> {
  bool hasLeft = false;
  bool pauseGame = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // print(screenSize.height);
    // print(MediaQuery.of(context).devicePixelRatio);
    bool isVertical = screenSize.height > screenSize.width;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return ScreenWrapper(
      screen: 'I Love',
      bottomBar: const SizedBox(),
      infoTitle: 'Baeb',
      infoDetails: 'You\'re the best baeb.',
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
      child: BaebBoard(
        isVertical: isVertical,
        colLength: isVertical ? 35 : 15,
        rowLength: isVertical ? 15 : 35,
        resetGameBoard: () => print('reset'),
        screenHeight: screenSize.height,
        statusBarHeight: statusBarHeight,
      ),
    );
  }
}
