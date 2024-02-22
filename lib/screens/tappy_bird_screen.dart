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
  bool hasGameStarted = false;

  // Bird variables
  static double birdY = 0;
  double birdInitialPos = birdY;
  double birdHeight = 0.1;
  double birdWidth = 0.1;
  double gravity = -4.9; // gravity pull
  double height = 0;
  double time = 0;
  double velocity = 3.5; // jump strength

  // Barrier variables
  static double barrierWidth = 0.5;
  static List<double> initBarrierX = [
    2,
    2 + 1.5,
    2 + 3,
    2 + 5,
    2 + 6.5,
    2 + 8,
    2 + 9,
    2 + 10.5,
  ];
  static List<List<double>> initBarrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
    [0.333, 0.666],
    [0.2, 0.4],
    [0.7, 0.5],
    [0.5, 0.25],
    [0.9, 0.7],
    [0.2, 0.4],
  ];
  List<double> barrierX = initBarrierX;
  List<List<double>> barrierHeight = initBarrierHeight;

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
        barrierX[i] += 3;
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

      barrierX = initBarrierX;
      barrierHeight = initBarrierHeight;
    });
  }

  void startGame() {
    hasGameStarted = true;

    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = gravity * (time * time) + velocity * time;

      setState(() {
        birdY = birdInitialPos - height;
      });

      if (isBirdDead()) {
        timer.cancel();
        gameOverPrompt();
      }

      moveMap();

      time += 0.01;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Tappy Bird',
      infoTitle: 'Tappy Bird',
      infoDetails: 'Tap to stay a float. Or don\'t..',
      backgroundOverride: Colors.transparent,
      content: GestureDetector(
        onTap: hasGameStarted ? jump : startGame,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: Stack(
                    children: [
                      LilBird(
                        birdHeight: birdHeight,
                        birdWidth: birdWidth,
                        birdY: birdY,
                      ),
                      Container(
                        alignment: const Alignment(0, -0.5),
                        child: Text(
                          hasGameStarted ? '' : 'T A P  T O  P L A Y',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // Top barrier 0
                      BirdBarrier(
                        barrierHeight: barrierHeight[0][0],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[0],
                        isThisBottomBarrier: false,
                      ),
                      // Bottom barrier 0
                      BirdBarrier(
                        barrierHeight: barrierHeight[0][1],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[0],
                        isThisBottomBarrier: true,
                      ),
                      // Top barrier 1
                      BirdBarrier(
                        barrierHeight: barrierHeight[1][0],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[1],
                        isThisBottomBarrier: false,
                      ),
                      // Bottom barrier 1
                      BirdBarrier(
                        barrierHeight: barrierHeight[1][1],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[1],
                        isThisBottomBarrier: true,
                      ),
                      // Top barrier 2
                      BirdBarrier(
                        barrierHeight: barrierHeight[2][0],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[2],
                        isThisBottomBarrier: false,
                      ),
                      // Bottom barrier 2
                      BirdBarrier(
                        barrierHeight: barrierHeight[2][1],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[2],
                        isThisBottomBarrier: true,
                      ),
                      // Top barrier 3
                      BirdBarrier(
                        barrierHeight: barrierHeight[3][0],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[3],
                        isThisBottomBarrier: false,
                      ),
                      // Bottom barrier 3
                      BirdBarrier(
                        barrierHeight: barrierHeight[3][1],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[3],
                        isThisBottomBarrier: true,
                      ),
                      // Top barrier 4
                      BirdBarrier(
                        barrierHeight: barrierHeight[4][0],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[4],
                        isThisBottomBarrier: false,
                      ),
                      // Bottom barrier 4
                      BirdBarrier(
                        barrierHeight: barrierHeight[4][1],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[4],
                        isThisBottomBarrier: true,
                      ),
                      // Top barrier 5
                      BirdBarrier(
                        barrierHeight: barrierHeight[5][0],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[5],
                        isThisBottomBarrier: false,
                      ),
                      // Bottom barrier 5
                      BirdBarrier(
                        barrierHeight: barrierHeight[5][1],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[5],
                        isThisBottomBarrier: true,
                      ),
                      // Top barrier 6
                      BirdBarrier(
                        barrierHeight: barrierHeight[6][0],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[6],
                        isThisBottomBarrier: false,
                      ),
                      // Bottom barrier 6
                      BirdBarrier(
                        barrierHeight: barrierHeight[6][1],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[6],
                        isThisBottomBarrier: true,
                      ),
                      // Top barrier 7
                      BirdBarrier(
                        barrierHeight: barrierHeight[7][0],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[7],
                        isThisBottomBarrier: false,
                      ),
                      // Bottom barrier 7
                      BirdBarrier(
                        barrierHeight: barrierHeight[7][1],
                        barrierWidth: barrierWidth,
                        barrierX: barrierX[7],
                        isThisBottomBarrier: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.secondary,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        alignment: const Alignment(-0.5, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 38,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'S C O R E',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: const Alignment(0.5, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '10',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 38,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'B E S T',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      screenFunction: (String string) {},
      bottomBar: const SizedBox(),
    );
  }
}
