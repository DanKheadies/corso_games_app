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
  // TODO: number of squares calculation based on widgetSize / screen size
  // iPhone 12 mini - device @ 812, widget @ 624 (diff 188) == 620 (31 rows)
  // iPhone 13 Pro Max - device @ 926, widget @ 741 (diff 185) == 660 (33 rows)
  // Android Pixel (??) - device @ 826.9, widget @ 673.5 (diff 153.4) == 660 (33 rows)
  // y = 0.34188 * x + 406.66667 (using widget)
  // y = 0.35088 * x + 335.08772 (using screen)
  // y = total # of squres
  // x = widget (column) / screen size

  late Timer snakeTimer;

  @override
  void initState() {
    super.initState();
    snakeTimer = Timer(
      const Duration(milliseconds: 10000),
      () {},
    );
  }

  int randomFood() {
    return Random().nextInt(widget.numberOfSquares);
  }

  void startGame() {
    pauseSnake();

    int gameSpeed = widget.snakeSpeed == SnakeSpeed.slow
        ? 500
        : widget.snakeSpeed == SnakeSpeed.average
            ? 300
            : widget.snakeSpeed == SnakeSpeed.fast
                ? 100
                : widget.snakeSpeed == SnakeSpeed.faster
                    ? 50
                    : widget.snakeSpeed == SnakeSpeed.hell
                        ? 25
                        : (2000 / widget.snakePosition.length).floor();

    context.read<SnakeBloc>().add(
          UpdateSnakeBoard(
            food: randomFood(),
            gameSpeed: gameSpeed,
            snakePosition: const [45, 65, 85, 105, 125],
            snakeStatus: SnakeStatus.play,
          ),
        );

    playSnake(gameSpeed);
  }

  void updateSnake() {
    tempPositions = List.from(widget.snakePosition);

    switch (widget.snakeDirection) {
      case SnakeDirection.down:
        if (widget.snakePosition.last > (widget.numberOfSquares - 20)) {
          tempPositions.add(tempPositions.last + 20 - widget.numberOfSquares);

          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        } else {
          tempPositions.add(tempPositions.last + 20);

          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        }
        break;

      case SnakeDirection.up:
        if (widget.snakePosition.last < 20) {
          tempPositions.add(tempPositions.last - 20 + widget.numberOfSquares);

          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        } else {
          tempPositions.add(tempPositions.last - 20);

          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        }
        break;

      case SnakeDirection.left:
        if (widget.snakePosition.last % 20 == 0) {
          tempPositions.add(tempPositions.last - 1 + 20);

          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        } else {
          tempPositions.add(tempPositions.last - 1);

          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        }
        break;

      case SnakeDirection.right:
        if ((widget.snakePosition.last + 1) % 20 == 0) {
          tempPositions.add(tempPositions.last + 1 - 20);
          context.read<SnakeBloc>().add(
                UpdateSnakeBoard(
                  snakePosition: tempPositions,
                ),
              );
        } else {
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

    if (widget.snakePosition.last == widget.food) {
      context.read<SnakeBloc>().add(
            UpdateSnakeBoard(
              food: randomFood(),
            ),
          );
    } else {
      tempPositions.removeAt(0);

      context.read<SnakeBloc>().add(
            UpdateSnakeBoard(
              snakePosition: tempPositions,
            ),
          );
    }

    if (widget.snakeSpeed == SnakeSpeed.progression) {
      if (snakeTimer.isActive) snakeTimer.cancel();
      playSnake((2000 / widget.snakePosition.length).floor());
    }

    if (widget.snakeStatus == SnakeStatus.pause) {
      pauseSnake();
    }
  }

  void pauseSnake() {
    if (snakeTimer.isActive) snakeTimer.cancel();
  }

  void playSnake(int? gameSpeed) {
    if (widget.food == 45) {
      context.read<SnakeBloc>().add(
            UpdateSnakeBoard(
              food: randomFood(),
            ),
          );
    }

    snakeTimer = Timer.periodic(
      Duration(milliseconds: gameSpeed ?? widget.gameSpeed),
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
    for (int i = 0; i < widget.snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < widget.snakePosition.length; j++) {
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
    context.read<SnakeBloc>().add(
          const UpdateSnakeBoard(
            snakeStatus: SnakeStatus.pause,
          ),
        );

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
                Navigator.of(context).pop();
                context.read<SnakeBloc>().add(
                      const ResetSnake(
                        snakeStatus: SnakeStatus.reset,
                      ),
                    );
              },
            ),
          ],
        );
      },
    );
  }

  void checkGameStatus(BuildContext context) {
    if (widget.snakeStatus == SnakeStatus.reset) {
      context.read<SnakeBloc>().add(
            const ResetSnake(
              snakeStatus: SnakeStatus.loaded,
            ),
          );
      startGame();
    } else if (widget.snakeStatus == SnakeStatus.unpause) {
      context.read<SnakeBloc>().add(
            const UpdateSnakeBoard(
              snakeStatus: SnakeStatus.play,
            ),
          );
      playSnake(widget.gameSpeed);
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (widget.snakeDirection != SnakeDirection.up &&
                    details.delta.dy > 0) {
                  // print('gesture down');
                  // TODO: repeats multipe times; is problem?
                  context.read<SnakeBloc>().add(
                        const UpdateSnakeBoard(
                          snakeDirection: SnakeDirection.down,
                        ),
                      );
                } else if (widget.snakeDirection != SnakeDirection.up &&
                    details.delta.dy < 0) {
                  // print('gesture up');
                  // TODO: repeats multipe times; is problem?
                  context.read<SnakeBloc>().add(
                        const UpdateSnakeBoard(
                          snakeDirection: SnakeDirection.up,
                        ),
                      );
                }
              },
              onHorizontalDragUpdate: (details) {
                if (widget.snakeDirection != SnakeDirection.left &&
                    details.delta.dx > 0) {
                  // print('gesture right');
                  // TODO: repeats multipe times; is problem?
                  context.read<SnakeBloc>().add(
                        const UpdateSnakeBoard(
                          snakeDirection: SnakeDirection.right,
                        ),
                      );
                } else if (widget.snakeDirection != SnakeDirection.right &&
                    details.delta.dx < 0) {
                  // print('gesture left');
                  // TODO: repeats multipe times; is problem?
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
                  itemCount: widget.numberOfSquares,
                  // itemCount: 660,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                  ),
                  itemBuilder: (context, index) {
                    if (widget.snakePosition.contains(index)) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      );
                    }
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
