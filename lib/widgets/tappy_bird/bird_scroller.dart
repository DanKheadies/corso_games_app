import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/widgets.dart';

class BirdScroller extends StatefulWidget {
  final double height;

  const BirdScroller({
    super.key,
    required this.height,
  });

  @override
  State<BirdScroller> createState() => _BirdScrollerState();
}

class _BirdScrollerState extends State<BirdScroller> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  // // Top barrier 2
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[2][0],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[2],
                  //   color: barrierColors[2],
                  //   isThisBottomBarrier: false,
                  // ),
                  // // Bottom barrier 2
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[2][1],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[2],
                  //   color: barrierColors[2],
                  //   isThisBottomBarrier: true,
                  // ),
                  // // Top barrier 3
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[3][0],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[3],
                  //   color: barrierColors[3],
                  //   isThisBottomBarrier: false,
                  // ),
                  // // Bottom barrier 3
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[3][1],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[3],
                  //   color: barrierColors[3],
                  //   isThisBottomBarrier: true,
                  // ),
                  // // Top barrier 4
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[4][0],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[4],
                  //   color: barrierColors[4],
                  //   isThisBottomBarrier: false,
                  // ),
                  // // Bottom barrier 4
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[4][1],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[4],
                  //   color: barrierColors[4],
                  //   isThisBottomBarrier: true,
                  // ),
                  // // Top barrier 5
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[5][0],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[5],
                  //   color: barrierColors[5],
                  //   isThisBottomBarrier: false,
                  // ),
                  // // Bottom barrier 5
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[5][1],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[5],
                  //   color: barrierColors[5],
                  //   isThisBottomBarrier: true,
                  // ),
                  // // Top barrier 6
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[6][0],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[6],
                  //   color: barrierColors[6],
                  //   isThisBottomBarrier: false,
                  // ),
                  // // Bottom barrier 6
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[6][1],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[6],
                  //   color: barrierColors[6],
                  //   isThisBottomBarrier: true,
                  // ),
                  // // Top barrier 7
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[7][0],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[7],
                  //   color: barrierColors[7],
                  //   isThisBottomBarrier: false,
                  // ),
                  // // Bottom barrier 7
                  // BirdBarrier(
                  //   barrierHeight: barrierHeight[7][1],
                  //   barrierWidth: barrierWidth,
                  //   barrierX: barrierX[7],
                  //   color: barrierColors[7],
                  //   isThisBottomBarrier: true,
                  // ),
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
                          '10',
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
    );
  }
}
