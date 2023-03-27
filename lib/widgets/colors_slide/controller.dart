import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
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
  // ScoreModel score = ScoreModel();
  // Random rnd = Random();
  List<GamePiece> _pieces = [];
  Map<Point, GamePiece> index = {};

  // int initGridSize = 3;
  // int gridSize = initGridSize;
  int gridSize = 3;

  // TODO: add waterfall / tetris effect and spawn circles faster and faster

  get pieces => _pieces;

  StreamController bus = StreamController.broadcast();
  StreamSubscription listen(void Function(dynamic) handler) {
    bus.stream.listen(handler);
    // return becauseItsNeeded;
    return bus.stream.listen((event) {});
  }

  // StreamSubscription becauseItsNeeded = bus.stream.listen((event) {});

  dispose() => bus.close();

  Direction lastDirection = Direction.right;

  Direction parse(Offset offset) {
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

  void addPiece(GamePiece piece) {
    _pieces.add(piece);
    index[piece.position] = piece;
  }

  void removePlace(GamePiece piece) {
    _pieces.remove(piece);
    index[piece.position] = GamePiece(
      model: GamePieceModel(
        position: const Point(0, 0),
        value: 0,
        cont: this,
      ),
    );
  }

  void on(Offset offset, BuildContext context) {
    lastDirection = parse(offset);
    process(lastDirection, context);

    bus.add(null);

    if (_pieces.length == (gridSize * gridSize)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text(
                'You can\'t add any more!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              // backgroundColor: Theme.of(context).colorScheme.surface,
            ),
          )
          .closed
          .then(
            (value) => ScaffoldMessenger.of(context).clearSnackBars(),
          );
      return;
    }

    Point p = Point(Random().nextInt(gridSize), Random().nextInt(gridSize));
    while (index.containsKey(p)) {
      p = Point(Random().nextInt(gridSize), Random().nextInt(gridSize));
    }

    addPiece(
      GamePiece(
        model: GamePieceModel(
          position: p,
          value: 0,
          cont: this,
        ),
      ),
    );
  }

  void process(
    Direction direction,
    BuildContext context,
  ) {
    switch (direction) {
      case (Direction.up):
        scan(
          0,
          gridSize,
          1,
          Axis.vertical,
          context,
        );
        break;
      case (Direction.down):
        scan(
          gridSize - 1,
          -1,
          -1,
          Axis.vertical,
          context,
        );
        break;
      case Direction.left:
        scan(
          0,
          gridSize,
          1,
          Axis.horizontal,
          context,
        );
        break;
      case Direction.right:
        scan(
          gridSize - 1,
          -1,
          -1,
          Axis.horizontal,
          context,
        );
        break;

      default:
        break;
    }
  }

  void scan(
    int start,
    int end,
    int op,
    Axis axis,
    BuildContext context,
  ) {
    for (int j = start; j != end; j += op) {
      for (int k = 0; k != gridSize; k++) {
        Point p = axis == Axis.vertical ? Point(k, j) : Point(j, k);
        if (index.containsKey(p)) {
          check(
            start,
            op,
            axis,
            index[p],
            context,
          );
        }
      }
    }
  }

  void check(
    int start,
    int op,
    Axis axis,
    GamePiece? piece,
    BuildContext context,
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
        return merge(
          piece,
          index[lookup],
          context,
        );
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

  void merge(
    GamePiece source,
    GamePiece? target,
    BuildContext context,
  ) {
    // see final List<Color> colors = const [ (in game_piece.dart)
    // [totalColors] - 1 = numBelow
    if (source.value == 12) {
      index.remove(source.position);
      index.remove(target!.position);
      _pieces.remove(source);
      _pieces.remove(target);
      // score.value += source.model.value * 100;
      context.read<ColorsSlideBloc>().add(
            UpdateColorsSlideScore(
              reset: false,
              increaseAmount: source.model.value * 100,
            ),
          );
      return;
    }

    source.model.value += 1;
    index.remove(target!.position);
    _pieces.remove(target);
    relocate(source, target.position);
    // score.value += source.model.value * 10;
    context.read<ColorsSlideBloc>().add(
          UpdateColorsSlideScore(
            reset: false,
            increaseAmount: source.model.value * 10,
          ),
        );
  }

  void relocate(GamePiece piece, Point destination) {
    index.remove(piece.position);
    piece.move(destination);
    index[piece.position] = piece;
  }

  void start(BuildContext context) {
    _pieces = [];
    index = {};
    on(const Offset(1, 0), context);
  }

  void restart(BuildContext context) {
    _pieces = [];
    index = {};
    // score.value = 0;
    context.read<ColorsSlideBloc>().add(
          const UpdateColorsSlideScore(
            reset: true,
            increaseAmount: 0,
          ),
        );
    on(const Offset(1, 0), context);
  }
}
