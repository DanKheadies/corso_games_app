import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/colors_slide/game_piece.dart';
import 'package:corso_games_app/widgets/colors_slide/score.dart';

enum Direction {
  up,
  down,
  left,
  right,
  none,
}

class Controller {
  static ScoreModel score = ScoreModel();
  static Random rnd = Random();
  static List<GamePiece> _pieces = [];
  static Map<Point, GamePiece> index = {};

  static int initGridSize = 3;
  static int gridSize = initGridSize;

  // TODO: add waterfall / tetris effect and spawn circles faster and faster

  static get pieces => _pieces;

  static StreamController bus = StreamController.broadcast();
  static StreamSubscription listen(void Function(dynamic) handler) {
    bus.stream.listen(handler);
    return becauseItsNeeded;
  }

  static StreamSubscription becauseItsNeeded = bus.stream.listen((event) {});

  static dispose() => bus.close();

  static Direction lastDirection = Direction.right;

  static Direction parse(Offset offset) {
    if (offset.dx < 0 && offset.dx.abs() > offset.dy.abs()) {
      return Direction.left;
    }
    if (offset.dx > 0 && offset.dx.abs() > offset.dy.abs()) {
      return Direction.right;
    }
    if (offset.dy < 0 && offset.dy.abs() > offset.dx.abs()) {
      return Direction.up;
    }
    if (offset.dy > 0 && offset.dy.abs() > offset.dx.abs()) {
      return Direction.down;
    }

    return Direction.none;
  }

  static addPiece(GamePiece piece) {
    _pieces.add(piece);
    index[piece.position] = piece;
  }

  static removePlace(GamePiece piece) {
    _pieces.remove(piece);
    index[piece.position] = GamePiece(
      model: GamePieceModel(
        position: const Point(0, 0),
        value: 0,
      ),
    );
  }

  static void on(Offset offset, BuildContext context) {
    lastDirection = parse(offset);
    process(lastDirection);

    bus.add(null);

    if (_pieces.length == (gridSize * gridSize)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: const Text('You can\'t add any more!'),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            ),
          )
          .closed
          .then(
            (value) => ScaffoldMessenger.of(context).clearSnackBars(),
          );
      return;
    }

    Point p = Point(rnd.nextInt(gridSize), rnd.nextInt(gridSize));
    while (index.containsKey(p)) {
      p = Point(rnd.nextInt(gridSize), rnd.nextInt(gridSize));
    }

    addPiece(
      GamePiece(
        model: GamePieceModel(
          position: p,
          value: 0,
        ),
      ),
    );
  }

  static void process(Direction direction) {
    switch (direction) {
      case (Direction.up):
        scan(0, gridSize, 1, Axis.vertical);
        break;
      case (Direction.down):
        scan(gridSize - 1, -1, -1, Axis.vertical);
        break;
      case Direction.left:
        scan(0, gridSize, 1, Axis.horizontal);
        break;
      case Direction.right:
        scan(gridSize - 1, -1, -1, Axis.horizontal);
        break;

      default:
        break;
    }
  }

  static scan(
    int start,
    int end,
    int op,
    Axis axis,
  ) {
    for (int j = start; j != end; j += op) {
      for (int k = 0; k != gridSize; k++) {
        Point p = axis == Axis.vertical ? Point(k, j) : Point(j, k);
        if (index.containsKey(p)) {
          check(start, op, axis, index[p]);
        }
      }
    }
  }

  static void check(
    int start,
    int op,
    Axis axis,
    GamePiece? piece,
  ) {
    num target =
        (axis == Axis.vertical) ? piece!.position.y : piece!.position.x;
    for (var n = target - op; n != start - op; n -= op) {
      Point lookup = (axis == Axis.vertical)
          ? Point(piece.position.x, n)
          : Point(n, piece.position.y);

      if (!index.containsKey(lookup)) {
        target -= op;
      } else if (index[lookup]?.value == piece.value) {
        return merge(piece, index[lookup]);
      } else {
        break;
      }
    }

    Point destination = (axis == Axis.vertical)
        ? Point(piece.position.x, target)
        : Point(target, piece.position.y);

    if (destination != piece.position) {
      relocate(piece, destination);
    }
  }

  static void merge(GamePiece source, GamePiece? target) {
    // see final List<Color> colors = const [ (in game_piece.dart)
    // [totalColors] - 1 = numBelow
    if (source.value == 12) {
      index.remove(source.position);
      index.remove(target!.position);
      _pieces.remove(source);
      _pieces.remove(target);
      score.value += source.model.value * 100;
      return;
    }

    source.model.value += 1;
    index.remove(target!.position);
    _pieces.remove(target);
    relocate(source, target.position);
    score.value += source.model.value * 10;
  }

  static void relocate(GamePiece piece, Point destination) {
    index.remove(piece.position);
    piece.move(destination);
    index[piece.position] = piece;
  }

  static void start(BuildContext context) {
    _pieces = [];
    index = {};
    on(const Offset(1, 0), context);
  }

  static void restart(BuildContext context) {
    _pieces = [];
    index = {};
    score.value = 0;
    on(const Offset(1, 0), context);
  }
}
