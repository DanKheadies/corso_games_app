import 'dart:async';

import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/widgets.dart';

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
  // Game settings
  late Timer tapTimer;
  bool hasGameStarted = false;
  double score = 0;

  // Bird variables
  static double birdY = 0;
  double birdInitialPos = birdY;
  double birdHeight = 0.1;
  double birdWidth = 0.1;
  double gravity = -1; // -4.20; // gravity pull
  double height = 0;
  double time = 0;
  double velocity = 1; // 2.125; // jump strength

  // Barrier variables
  static double barrierWidth = 0.5;
  static List<double> initBarrierX = [
    2,
    3.5,
    // 5,
    // 7,
    // 8.5,
    // 10,
    // 11,
    // 12.5,
  ];
  // X value = 0 is top of screen, 1 is midway
  // Y value = 0 is bottom of screen, 1 is midway
  static List<List<double>> initBarrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
    // [0.1, 1.0],
    // [0, 0], // [0.7, 0.2],
    // [0, 0], // [1.0, 0.0],
    // [0, 0], // [0.5, 0.35],
    // [0, 0], // [0.4, 0.8],
    // [0, 0], // [0.666, 0.0], // 0.75
  ];
  List<double> barrierX = initBarrierX;
  List<List<double>> barrierHeight = initBarrierHeight;

  List<Color> barrierColors = [
    Colors.black,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  bool isBirdDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  void gameOverPrompt() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Center(
              child: Text(
                'G A M E  O V E R',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: Theme.of(context).colorScheme.surface,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      birdInitialPos = birdY;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.01;
      });

      if (barrierX[i] < -1.5) {
        // if (barrierX[i] < -12) {
        barrierX[i] += 3;
        // barrierX[i] += 12;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);

    // TODO: map not resetting
    setState(() {
      birdY = 0;
      birdInitialPos = birdY;
      hasGameStarted = false;
      time = 0;

      // barrierHeight = initBarrierHeight;
      // barrierX = initBarrierX;
      barrierX = [
        2,
        3.5,
        // 5,
        // 7,
        // 8.5,
        // 10,
        // 11,
        // 12.5,
      ];
    });
  }

  void startGame() {
    hasGameStarted = true;

    tapTimer = Timer.periodic(
      const Duration(milliseconds: 10),
      (_) {
        height = gravity * (time * time) + velocity * time;

        setState(() {
          birdY = birdInitialPos - height;
          score += time * .01;
        });

        if (isBirdDead()) {
          // timer.cancel();
          tapTimer.cancel();
          gameOverPrompt();
        }

        moveMap();

        time += 0.01;
      },
    );
  }

  @override
  void dispose() {
    tapTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build tb screen');
    double height = MediaQuery.of(context).size.height;

    return ScreenWrapper(
      title: 'Tappy Bird',
      infoTitle: 'Tappy Bird',
      infoDetails: 'Tap to stay a float. Or don\'t..',
      backgroundOverride: Colors.transparent,
      content: GestureDetector(
        onTap: hasGameStarted ? jump : startGame,
        child: BirdScroller(
          height: height,
        ),
      ),
      screenFunction: (String string) {},
      bottomBar: const SizedBox(),
    );
  }
}
