import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TappyBirdScreen extends StatefulWidget {
  static const String routeName = '/tappy-bird';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const TappyBirdScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const TappyBirdScreen({Key? key}) : super(key: key);

  @override
  State<TappyBirdScreen> createState() => _TappyBirdScreenState();
}

class _TappyBirdScreenState extends State<TappyBirdScreen> {
  bool pauseGame = false;
  bool isLeaving = false;

  @override
  Widget build(BuildContext context) {
    // print('build tb screen');
    double height = MediaQuery.of(context).size.height;

    return ScreenWrapper(
      title: 'Tappy Bird',
      infoTitle: 'Tappy Bird',
      infoDetails: 'Tap to stay a float. Or don\'t..',
      backgroundOverride: Colors.transparent,
      content: BirdGame(
        height: height,
        isLeaving: isLeaving,
        pauseGame: pauseGame,
      ),
      screenFunction: (String string) {
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
      },
      bottomBar: const SizedBox(),
    );
  }
}
