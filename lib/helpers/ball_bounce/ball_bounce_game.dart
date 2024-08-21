import 'dart:math';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BallBounceGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  final BuildContext context;

  BallBounceGame({
    super.children,
    required this.context,
  });

  late BallBounceBall ball;
  late BallBounceBoard board;
  int numberOfBricksLayer = 1;
  final Random _random = Random();

  final int numberOfBricksInRow = 7;
  final int brickPadding = 8;
  final int maxValueOfBrick = 10;
  final int minValueOfBrick = -5;

  @override
  Future<void> onLoad() async {
    ball = BallBounceBall(context: context);
    board = BallBounceBoard(context: context);

    await super.onLoad();

    ball.priority = 1;
    addAll([
      board,
      ball,
    ]);
    loadInitialBrickLayer();
  }

  void resetGame(BuildContext context) {
    pauseEngine();
    overlays.remove('gamePauseOverlay');
    overlays.remove('gameOverOverlay');

    children.whereType<BallBounceBrick>().forEach((brick) {
      brick.removeFromParent();
    });

    context.read<BallBounceCubit>().reset();

    ball.resetBall();
    board.resetBoard();
    resumeEngine();

    numberOfBricksLayer = 1;
    loadInitialBrickLayer();
  }

  void togglePauseState() {
    if (paused) {
      overlays.remove('gamePauseOverlay');
      resumeEngine();
    } else {
      overlays.add('gamePauseOverlay');
      pauseEngine();
    }
  }

  double get brickSize {
    final totalPadding = (numberOfBricksInRow + 1) * brickPadding;
    final screenMinSize = size.x < size.y ? size.x : size.y;
    return (screenMinSize - totalPadding) / numberOfBricksInRow;
  }

  int next(int min, int max) => min + _random.nextInt(max);

  List<BallBounceBrick> generateBrickLayer(int row) {
    return List<BallBounceBrick>.generate(
      numberOfBricksInRow,
      (index) => BallBounceBrick(
        brickValue: next(minValueOfBrick, maxValueOfBrick),
        size: brickSize,
        brickRow: row,
        brickColumn: index,
        context: context,
      ),
    );
  }

  Future<void> loadInitialBrickLayer() async {
    for (var row = 0; row < numberOfBricksLayer; row++) {
      final bricksLayer = generateBrickLayer(row);
      for (var i = 0; i < numberOfBricksInRow; i++) {
        final xPosition = i == 0
            ? 8
            : bricksLayer[i - 1].position.x + bricksLayer[i - 1].size.x + 8;
        final yPosition = (row + 1) * (brickSize + 8);

        await add(
          bricksLayer[i]..position = Vector2(xPosition.toDouble(), yPosition),
        );
      }
    }
  }

  Future<void> removeBrickLayerRow(int row) async {
    final bricksToRemove = children
        .whereType<BallBounceBrick>()
        .toList()
        .where((element) => element.brickRow == row);

    for (final brick in bricksToRemove) {
      brick.removeFromParent();
    }
  }

  Future<void> removeBrickLayerColumn(int column) async {
    final bricksToRemove = children
        .whereType<BallBounceBrick>()
        .toList()
        .where((element) => element.brickColumn == column);

    for (final brick in bricksToRemove) {
      brick.removeFromParent();
    }
  }

  @override
  Future<void> update(double dt) async {
    if (ball.ballState == BallState.completed) {
      await updateBrickPositions();
    }

    super.update(dt);
  }

  Future<void> updateBrickPositions() async {
    var ballCont = context.read<BallBounceCubit>();
    final brickComponents = children.whereType<BallBounceBrick>().toList();

    for (final brick in brickComponents) {
      final nextYPosition = brick.position.y + brickSize + 8;
      if (board.size.y - ball.size.y <= nextYPosition + brick.size.y) {
        pauseEngine();

        context.read<BallBounceCubit>().gameOver();

        ball.ballState = BallState.ideal;

        overlays.add('gameOverOverlay');

        return;
      }
      brick.position.y = nextYPosition;
    }

    final bricksLayer = generateBrickLayer(numberOfBricksLayer);
    for (var i = 0; i < 7; i++) {
      await add(
        bricksLayer[i]
          ..position = Vector2(
            i == 0
                ? 8
                : bricksLayer[i - 1].position.x + bricksLayer[i - 1].size.x + 8,
            brickSize + 8,
          ),
      );
    }
    numberOfBricksLayer++;
    ball.ballState = BallState.ideal;

    ballCont.increaseScore();
  }

  void increaseBallSpeed() {
    ball.increaseSpeed();
  }
}
