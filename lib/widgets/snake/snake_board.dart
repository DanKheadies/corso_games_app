import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class SnakeBoard extends StatefulWidget {
  final int food;
  final int gameSpeed;
  final int numberOfSquares;
  final List<int> snakePosition;
  final SnakeDirection snakeDirection;
  final SnakeSpeed snakeSpeed;
  final SnakeStatus snakeStatus;

  const SnakeBoard({
    super.key,
    required this.food,
    required this.gameSpeed,
    required this.numberOfSquares,
    required this.snakePosition,
    required this.snakeDirection,
    required this.snakeSpeed,
    required this.snakeStatus,
  });

  @override
  State<SnakeBoard> createState() => _SnakeBoardState();
}

class _SnakeBoardState extends State<SnakeBoard> {
  List<int> tempPositions = [];
  // int food = 45;
  // int gameSpeed = 300;
  // int numberOfSquares = 620; // 760
  // TODO: number of squares calculation based on widgetSize / screen size
  // iPhone 12 mini - device @ 812, widget @ 624
  // List<int> snakePosition = [];
  // String direction = 'down';
  // String gameStatus = 'pause';

  late Timer snakeTimer;

  @override
  void initState() {
    super.initState();
    // snakePosition = [45, 65, 85, 105, 125];
    // snakePosition = widget.snakePosition;
    snakeTimer = Timer(
      const Duration(milliseconds: 10000),
      () {},
    );
    print('init');
  }

  // void generateNewFood() {
  //   food = Random().nextInt(numberOfSquares);
  //   // TODO: bloc state food update
  //   // print('food: $food');
  // }

  int randomFood() {
    return Random().nextInt(widget.numberOfSquares);
  }

  void startGame() {
    print('start');
    pauseSnake();

    // if (widget.snakeSpeed == SnakeSpeed.slow) {
    //   gameSpeed = 500;
    //   // context.read<SnakeBloc>().add(
    //   //   const UpdateSnakeBoard(
    //   //     gameSpeed: 500,
    //   //   ),
    //   // );
    // } else if (widget.snakeSpeed == SnakeSpeed.average) {
    //   gameSpeed = 300;
    // } else if (widget.snakeSpeed == SnakeSpeed.fast) {
    //   gameSpeed = 150;
    // } else if (widget.snakeSpeed == SnakeSpeed.faster) {
    //   gameSpeed = 100;
    // } else if (widget.snakeSpeed == SnakeSpeed.hell) {
    //   gameSpeed = 50;
    //   // } else if (widget.snakeSpeed == SnakeSpeed.why) {
    //   //   gameSpeed = (2000 / widget.snakePosition.length).floor();
    // }

    context.read<SnakeBloc>().add(
          UpdateSnakeBoard(
            food: randomFood(),
            gameSpeed: widget.snakeSpeed == SnakeSpeed.slow
                ? 500
                : widget.snakeSpeed == SnakeSpeed.average
                    ? 300
                    : widget.snakeSpeed == SnakeSpeed.fast
                        ? 150
                        : widget.snakeSpeed == SnakeSpeed.faster
                            ? 100
                            : widget.snakeSpeed == SnakeSpeed.hell
                                ? 50
                                : (2000 / widget.snakePosition.length).floor(),
            snakePosition: const [45, 65, 85, 105, 125],
            snakeStatus: SnakeStatus.play,
          ),
        );

    // gameStatus = 'play';
    // snakePosition = [45, 65, 85, 105, 125];
    // generateNewFood();
    // snakeTimer = Timer.periodic(
    //   Duration(milliseconds: gameSpeed),
    //   (timer) {
    //     updateSnake();
    //     if (isGameOver()) {
    //       timer.cancel();
    //       gameOver();
    //     }
    //   },
    // );
    playSnake();
  }

  void updateSnake() {
    print('update');
    tempPositions = List.from(widget.snakePosition);
    print(tempPositions);
    // setState(() {

    // });
    // switch (direction) {
    switch (widget.snakeDirection) {
      // case 'down':
      case SnakeDirection.down:
        if (widget.snakePosition.last > (widget.numberOfSquares - 20)) {
          // snakePosition.add(snakePosition.last + 20 - numberOfSquares);
          // tempPositions = List.from(widget.snakePosition);
          tempPositions.add(tempPositions.last + 20 - widget.numberOfSquares);
          // print('if down update');
          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        } else {
          // snakePosition.add(snakePosition.last + 20);
          // var derp = widget.snakePosition;
          // List<int> tempPositions = List.from(widget.snakePosition);
          // print('daco');
          // print(tempPositions);
          tempPositions.add(tempPositions.last + 20);
          // print(tempPositions);
          // print('down update');
          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        }
        break;

      // case 'up':
      case SnakeDirection.up:
        if (widget.snakePosition.last < 20) {
          // snakePosition.add(snakePosition.last - 20 + numberOfSquares);
          // List<int> tempPositions = List.from(widget.snakePosition);
          tempPositions.add(tempPositions.last - 20 + widget.numberOfSquares);
          // print('if up update');
          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        } else {
          // snakePosition.add(snakePosition.last - 20);
          // List<int> tempPositions = List.from(widget.snakePosition);
          tempPositions.add(tempPositions.last - 20);
          // print('up update');
          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        }
        break;

      // case 'left':
      case SnakeDirection.left:
        if (widget.snakePosition.last % 20 == 0) {
          // snakePosition.add(snakePosition.last - 1 + 20);
          // List<int> tempPositions = List.from(widget.snakePosition);
          tempPositions.add(tempPositions.last - 1 + 20);
          // print('if left update');
          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        } else {
          // snakePosition.add(snakePosition.last - 1);
          // List<int> tempPositions = List.from(widget.snakePosition);
          tempPositions.add(tempPositions.last - 1);
          // print('left update');
          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        }
        break;

      // case 'right':
      case SnakeDirection.right:
        if ((widget.snakePosition.last + 1) % 20 == 0) {
          // snakePosition.add(snakePosition.last + 1 - 20);
          // List<int> tempPositions = List.from(widget.snakePosition);
          tempPositions.add(tempPositions.last + 1 - 20);
          // print('if right update');
          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        } else {
          print('right update');
          // snakePosition.add(snakePosition.last + 1);
          // List<int> tempPositions = List.from(widget.snakePosition);
          tempPositions.add(tempPositions.last + 1);

          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        }
        break;

      default:
        break;
    }
    // print('daco');
    // print(tempPositions);

    if (widget.snakePosition.last == widget.food) {
      // generateNewFood();
      print('food update');
      context.read<SnakeBloc>().add(
            UpdateSnakeBoard(
              food: randomFood(),
            ),
          );
    } else {
      print('moving..');
      print(tempPositions);
      // snakePosition.removeAt(0);
      // List<int>? tempPositions = List.from(widget.snakePosition);
      // print('taco');
      // print(tempPositions);
      tempPositions.removeAt(0);
      print(tempPositions);
      // print('remove update');
      // print(tempPositions);
      // UpdateSnakeBoard(
      //   snakePosition: tempPositions,
      // );

      context.read<SnakeBloc>().add(
            UpdateSnakeBoard(
              snakePosition: tempPositions,
            ),
          );
    }

    // TODO: handle issues (?) from multi-UpdateSnakeBoards
    if (widget.snakeSpeed == SnakeSpeed.why) {
      print('why');
      pauseSnake();

      // gameSpeed = (2000 / widget.snakePosition.length).floor();
      context.read<SnakeBloc>().add(
            UpdateSnakeBoard(
              gameSpeed: (2000 / widget.snakePosition.length).floor(),
            ),
          );

      Timer.periodic(
        Duration(milliseconds: widget.gameSpeed),
        (timer) {
          updateSnake();
          if (isGameOver()) {
            timer.cancel();
            gameOver();
          }
        },
      );
    }

    if (widget.snakeStatus == SnakeStatus.pause) {
      print('update pause');
      pauseSnake();
    }
  }

  void pauseSnake() {
    print('pause');
    if (snakeTimer.isActive) snakeTimer.cancel();
  }

  void playSnake() {
    print('play');
    if (widget.food == 45) {
      context.read<SnakeBloc>().add(
            UpdateSnakeBoard(
              food: randomFood(),
            ),
          );
    }
    snakeTimer = Timer.periodic(
      Duration(milliseconds: widget.gameSpeed),
      (timer) {
        updateSnake();
        if (isGameOver()) {
          timer.cancel();
          gameOver();
        }
      },
    );
  }

  bool isGameOver() {
    // for (int i = 0; i < snakePosition.length; i++) {
    for (int i = 0; i < widget.snakePosition.length; i++) {
      int count = 0;
      // for (int j = 0; j < snakePosition.length; j++) {
      for (int j = 0; j < widget.snakePosition.length; j++) {
        // if (snakePosition[i] == snakePosition[j]) {
        if (widget.snakePosition[i] == widget.snakePosition[j]) {
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
    // setState(() {
    //   gameStatus = 'pause';
    // });
    print('game over');
    context.read<SnakeBloc>().add(
          const UpdateSnakeBoard(
            snakeStatus: SnakeStatus.pause,
          ),
        );

    // snakeTimer.cancel();
    pauseSnake();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(
              'And in the end, you snaked by with ${widget.snakePosition.length} points.'),
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

  void checkGameStatus(BuildContext context) {
    print('check');
    if (widget.snakeStatus == SnakeStatus.reset) {
      print('reset');
      context.read<SnakeBloc>().add(
            const ResetSnake(
              snakeStatus: SnakeStatus.loaded,
            ),
          );
      startGame();
    } else if (widget.snakeStatus == SnakeStatus.unpause) {
      print('unpause');
      context.read<SnakeBloc>().add(
            const UpdateSnakeBoard(
              snakeStatus: SnakeStatus.play,
            ),
          );
      playSnake();
    }
  }

  @override
  void dispose() {
    snakeTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkGameStatus(context);
    print('build');

    return WidgetSize(
      onChange: (Size size) {
        print('widget height: ${size.height}');
      },
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                // if (direction != 'up' && details.delta.dy > 0) {
                //   direction = 'down';
                // } else if (direction != 'down' && details.delta.dy < 0) {
                //   direction = 'up';
                // }
                if (widget.snakeDirection != SnakeDirection.up &&
                    details.delta.dy > 0) {
                  // direction = 'down';
                  print('gesture down');
                  context.read<SnakeBloc>().add(
                        const UpdateSnakeBoard(
                          snakeDirection: SnakeDirection.down,
                        ),
                      );
                } else if (widget.snakeDirection != SnakeDirection.up &&
                    details.delta.dy < 0) {
                  // direction = 'up';
                  print('gesture up');
                  context.read<SnakeBloc>().add(
                        const UpdateSnakeBoard(
                          snakeDirection: SnakeDirection.up,
                        ),
                      );
                }
              },
              onHorizontalDragUpdate: (details) {
                // if (direction != 'left' && details.delta.dx > 0) {
                //   direction = 'right';
                // } else if (direction != 'right' && details.delta.dx < 0) {
                //   direction = 'left';
                // }
                if (widget.snakeDirection != SnakeDirection.left &&
                    details.delta.dx > 0) {
                  // direction = 'right';
                  print('gesture right');
                  context.read<SnakeBloc>().add(
                        const UpdateSnakeBoard(
                          snakeDirection: SnakeDirection.right,
                        ),
                      );
                } else if (widget.snakeDirection != SnakeDirection.right &&
                    details.delta.dx < 0) {
                  // direction = 'left';
                  print('gesture left');
                  context.read<SnakeBloc>().add(
                        const UpdateSnakeBoard(
                          snakeDirection: SnakeDirection.left,
                        ),
                      );
                }
              },
              child: SizedBox(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: numberOfSquares,
                  itemCount: widget.numberOfSquares,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                  ),
                  itemBuilder: (context, index) {
                    // if (snakePosition.contains(index)) {
                    if (widget.snakePosition.contains(index)) {
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
                    // if (index == food) {
                    if (index == widget.food) {
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
    );
  }
}
