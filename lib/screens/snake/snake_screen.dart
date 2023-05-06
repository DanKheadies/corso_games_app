import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/widgets.dart';

class SnakeScreen extends StatefulWidget {
  static const String routeName = '/snake';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SnakeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SnakeScreen({super.key});

  @override
  State<SnakeScreen> createState() => _SnakeScreenState();
}

class _SnakeScreenState extends State<SnakeScreen> {
  int food = 45;
  int gameSpeed = 300;
  int numberOfSquares = 620; // 760
  // int randomNumber = Random().nextInt(700);
  List<int> snakePosition = [];
  String direction = 'down';
  String gameStatus = 'pause';

  late Timer snakeTimer;

  @override
  void initState() {
    super.initState();
    snakePosition = [45, 65, 85, 105, 125];
    snakeTimer = Timer(
      const Duration(milliseconds: 1),
      () {},
    );
  }

  void generateNewFood() {
    // randomNumber = Random().nextInt(700);
    food = Random().nextInt(700);
    print('food: $food');
  }

  void startGame() {
    if (snakeTimer.isActive) snakeTimer.cancel();
    gameStatus = 'play';
    snakePosition = [45, 65, 85, 105, 125];
    generateNewFood();
    snakeTimer = Timer.periodic(
      Duration(milliseconds: gameSpeed),
      (timer) {
        updateSnake();
        if (isGameOver()) {
          timer.cancel();
          gameOver();
        }
      },
    );
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last > (numberOfSquares - 20)) {
            snakePosition.add(snakePosition.last + 20 - numberOfSquares);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;

        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last - 20 + numberOfSquares);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;

        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;

        case 'right':
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;

        default:
          break;
      }

      if (snakePosition.last == food) {
        generateNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool isGameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  void gameOver() {
    setState(() {
      gameStatus = 'pause';
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(
              'And in the end, you snaked by with ${snakePosition.length} points.'),
          actions: [
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                startGame();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    snakeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Snake',
      infoTitle: 'Snake',
      infoDetails:
          'Swipe the screen to change the snake\'s direction. Eat the food, avoid yourself!',
      button: 'Leggooo!',
      backgroundOverride: Theme.of(context).scaffoldBackgroundColor,
      content: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (direction != 'up' && details.delta.dy > 0) {
                  direction = 'down';
                } else if (direction != 'down' && details.delta.dy < 0) {
                  direction = 'up';
                }
              },
              onHorizontalDragUpdate: (details) {
                if (direction != 'left' && details.delta.dx > 0) {
                  direction = 'right';
                } else if (direction != 'right' && details.delta.dx < 0) {
                  direction = 'left';
                }
              },
              child: SizedBox(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                  ),
                  itemBuilder: (context, index) {
                    if (snakePosition.contains(index)) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              // color: Colors.white,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      );
                    }
                    if (index == food) {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withAlpha(150),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      screenFunction: (String string) {},
      // bottomBar: const BottomAppBar(),
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Settings',
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Share',
              icon: Icon(
                Icons.ios_share_outlined,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingButton: FloatingActionButton(
        onPressed: startGame,
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          icon: Icon(
            gameStatus == 'pause'
                ? Icons.play_arrow
                : Icons.settings_backup_restore_rounded,
            color: Theme.of(context).colorScheme.background,
            size: 30,
          ),
          onPressed: startGame,
        ),
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
