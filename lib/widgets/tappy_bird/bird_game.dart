import 'dart:async';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BirdGame extends StatefulWidget {
  final bool isLeaving;
  final bool pauseGame;
  final double height;

  const BirdGame({
    super.key,
    required this.height,
    required this.isLeaving,
    required this.pauseGame,
  });

  @override
  State<BirdGame> createState() => _BirdGameState();
}

class _BirdGameState extends State<BirdGame> {
  // Game settings
  late Timer tapTimer;
  bool hasGameStarted = false;
  bool isPaused = false;
  double score = 0;

  // Bird variables
  double birdY = 0;
  double birdHeight = 0.1;
  double birdWidth = 0.1;
  double gravity = -4.20; // -1; // -4.20; // gravity pull
  double height = 0;
  double time = 0;
  double velocity = 2.125; // 1; // 2.125; // jump strength
  late double birdInitialPos;

  // Barrier variables
  double barrierWidth = 0.5;
  List<double> initBarrierX = [
    2,
    3.5,
    5,
    7,
    8.5,
    10,
    11,
    12.5,
  ];
  // X value = 0 is top of screen, 1 is midway
  // Y value = 0 is bottom of screen, 1 is midway
  List<List<double>> initBarrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
    [0.1, 1.0],
    [0.7, 0.2],
    [1.0, 0.3],
    [0.5, 0.35],
    [0.4, 0.8],
    [0.666, 0.75],
  ];
  late List<double> barrierX = initBarrierX;
  late List<List<double>> barrierHeight = initBarrierHeight;

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

  @override
  void initState() {
    super.initState();

    barrierX = initBarrierX;
    barrierHeight = initBarrierHeight;
    birdInitialPos = birdY;
  }

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

      // if (barrierX[i] < -1.5) {
      if (barrierX[i] < -11) {
        // barrierX[i] += 3;
        barrierX[i] += 12.5;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);

    setState(() {
      birdY = 0;
      birdInitialPos = birdY;
      hasGameStarted = false;
      score = 0;
      time = 0;

      barrierX = [
        2,
        3.5,
        5,
        7,
        8.5,
        10,
        11,
        12.5,
      ];
    });
  }

  void initializeTimer() {
    // print('init timer');
    tapTimer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) {
        // print('run timer: ${timer.tick}');
        height = gravity * (time * time) + velocity * time;

        setState(() {
          birdY = birdInitialPos - height;
          score += time * .1;
        });

        if (isBirdDead()) {
          tapTimer.cancel();
          timer.cancel();
          gameOverPrompt();
          context.read<TappyBirdCubit>().updateScore(score.toInt());
        }

        moveMap();

        time += 0.01;
      },
    );
  }

  void startGame() {
    hasGameStarted = true;

    initializeTimer();
  }

  void cancelTimer() {
    // print('cancel timer');
    tapTimer.cancel();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pauseGame && !isPaused) {
      // print('pause');
      tapTimer.cancel();
      setState(() {
        isPaused = !isPaused;
      });
    } else if (!widget.pauseGame && isPaused) {
      // print('unpause');
      initializeTimer();
      setState(() {
        isPaused = !isPaused;
      });
    }

    if (widget.isLeaving) {
      // print('game leaving');
      cancelTimer();
    }

    // print('build game: $time');
    return GestureDetector(
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
                      screenHeight: widget.height,
                    ),
                    // Top barrier 0
                    BirdBarrier(
                      barrierHeight: barrierHeight[0][0],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[0],
                      color: barrierColors[0],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 0
                    BirdBarrier(
                      barrierHeight: barrierHeight[0][1],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[0],
                      color: barrierColors[0],
                      isThisBottomBarrier: true,
                    ),
                    // Top barrier 1
                    BirdBarrier(
                      barrierHeight: barrierHeight[1][0],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[1],
                      color: barrierColors[1],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 1
                    BirdBarrier(
                      barrierHeight: barrierHeight[1][1],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[1],
                      color: barrierColors[1],
                      isThisBottomBarrier: true,
                    ),
                    // Top barrier 2
                    BirdBarrier(
                      barrierHeight: barrierHeight[2][0],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[2],
                      color: barrierColors[2],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 2
                    BirdBarrier(
                      barrierHeight: barrierHeight[2][1],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[2],
                      color: barrierColors[2],
                      isThisBottomBarrier: true,
                    ),
                    // Top barrier 3
                    BirdBarrier(
                      barrierHeight: barrierHeight[3][0],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[3],
                      color: barrierColors[3],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 3
                    BirdBarrier(
                      barrierHeight: barrierHeight[3][1],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[3],
                      color: barrierColors[3],
                      isThisBottomBarrier: true,
                    ),
                    // Top barrier 4
                    BirdBarrier(
                      barrierHeight: barrierHeight[4][0],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[4],
                      color: barrierColors[4],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 4
                    BirdBarrier(
                      barrierHeight: barrierHeight[4][1],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[4],
                      color: barrierColors[4],
                      isThisBottomBarrier: true,
                    ),
                    // Top barrier 5
                    BirdBarrier(
                      barrierHeight: barrierHeight[5][0],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[5],
                      color: barrierColors[5],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 5
                    BirdBarrier(
                      barrierHeight: barrierHeight[5][1],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[5],
                      color: barrierColors[5],
                      isThisBottomBarrier: true,
                    ),
                    // Top barrier 6
                    BirdBarrier(
                      barrierHeight: barrierHeight[6][0],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[6],
                      color: barrierColors[6],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 6
                    BirdBarrier(
                      barrierHeight: barrierHeight[6][1],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[6],
                      color: barrierColors[6],
                      isThisBottomBarrier: true,
                    ),
                    // Top barrier 7
                    BirdBarrier(
                      barrierHeight: barrierHeight[7][0],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[7],
                      color: barrierColors[7],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 7
                    BirdBarrier(
                      barrierHeight: barrierHeight[7][1],
                      barrierWidth: barrierWidth,
                      barrierX: barrierX[7],
                      color: barrierColors[7],
                      isThisBottomBarrier: true,
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
                            score.toInt().toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 38,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'S C O R E',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
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
                            context.read<TappyBirdCubit>().state.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 38,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'B E S T',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
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
    );
  }
}
