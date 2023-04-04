import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';

ColorsSlideDirection lastDirection = ColorsSlideDirection.right;

class Controller {
  // TODO: add waterfall / tetris effect and spawn circles faster and faster

  StreamController bus = StreamController.broadcast();
  StreamSubscription listen(void Function(dynamic) handler) {
    bus.stream.listen(handler);
    return bus.stream.listen((event) {});
  }

  dispose() => bus.close();

  ColorsSlideDirection parse(Offset offset) {
    if (offset.dx < 0 && offset.dx.abs() > offset.dy.abs()) {
      return ColorsSlideDirection.left;
    }
    if (offset.dx > 0 && offset.dx.abs() > offset.dy.abs()) {
      return ColorsSlideDirection.right;
    }
    if (offset.dy < 0 && offset.dy.abs() > offset.dx.abs()) {
      return ColorsSlideDirection.up;
    }
    if (offset.dy > 0 && offset.dy.abs() > offset.dx.abs()) {
      return ColorsSlideDirection.down;
    }

    return ColorsSlideDirection.none;
  }

  void addPiece(
    BuildContext context,
    GamePiece piece,
    List<GamePiece> pieces,
    Map<Point, GamePiece> index,
  ) {
    pieces.add(piece);
    index[piece.position] = piece;

    context.read<ColorsSlideBloc>().add(
          const UpdateColorsSlideScore(
            reset: false,
            increaseAmount: 1,
          ),
        );
    context.read<ColorsSlideBloc>().add(
          UpdateColorsSlidePieces(
            index: index,
            pieces: pieces,
          ),
        );
  }

  // Handles moving / combining / etc pieces using the user input
  void on(
    BuildContext context,
    Offset offset,
    int gridSize,
    List<GamePiece> pieces,
    Map<Point, GamePiece> index,
  ) {
    // Identifies a Direction (or lack thereof)
    lastDirection = parse(offset);

    // Decides how to push / merge pieces and add a new  one
    process(
      context,
      lastDirection,
      gridSize,
      pieces,
      index,
    );

    // Needed to make the pieces appear / happen
    bus.add(null);

    // No more room at the inn
    if (pieces.length == (gridSize * gridSize)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text(
                'You can\'t add any more!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          )
          .closed
          .then(
            (value) => ScaffoldMessenger.of(context).clearSnackBars(),
          );
      return;
    }

    // Find a random, open space
    Point p = Point(Random().nextInt(gridSize), Random().nextInt(gridSize));
    while (index.containsKey(p)) {
      p = Point(Random().nextInt(gridSize), Random().nextInt(gridSize));
    }

    // Add a piece to the grid
    addPiece(
      context,
      GamePiece(
        model: GamePieceModel(
          position: p,
          value: 0,
          // cont: this,
          gridSize: gridSize,
        ),
        gridSize: gridSize,
      ),
      pieces,
      index,
    );
  }

  void process(
    BuildContext context,
    ColorsSlideDirection direction,
    int gridSize,
    List<GamePiece> pieces,
    Map<Point, GamePiece> index,
  ) {
    switch (direction) {
      case (ColorsSlideDirection.up):
        scan(
          context,
          Axis.vertical,
          gridSize,
          0,
          gridSize,
          1,
          pieces,
          index,
        );
        break;
      case (ColorsSlideDirection.down):
        scan(
          context,
          Axis.vertical,
          gridSize,
          gridSize - 1,
          -1,
          -1,
          pieces,
          index,
        );
        break;
      case ColorsSlideDirection.left:
        scan(
          context,
          Axis.horizontal,
          gridSize,
          0,
          gridSize,
          1,
          pieces,
          index,
        );
        break;
      case ColorsSlideDirection.right:
        scan(
          context,
          Axis.horizontal,
          gridSize,
          gridSize - 1,
          -1,
          -1,
          pieces,
          index,
        );
        break;

      default:
        break;
    }
  }

  void scan(
    BuildContext context,
    Axis axis,
    int gridSize,
    int start,
    int end,
    int op,
    List<GamePiece> pieces,
    Map<Point, GamePiece> index,
  ) {
    for (int j = start; j != end; j += op) {
      for (int k = 0; k != gridSize; k++) {
        Point p = axis == Axis.vertical ? Point(k, j) : Point(j, k);
        if (index.containsKey(p)) {
          check(
            context,
            axis,
            index[p],
            start,
            op,
            pieces,
            index,
          );
        }
      }
    }
  }

  void check(
    BuildContext context,
    Axis axis,
    GamePiece? piece,
    int start,
    int op,
    List<GamePiece> pieces,
    Map<Point, GamePiece> index,
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
          context,
          piece,
          index[lookup],
          pieces,
          index,
        );
      } else {
        break;
      }
    }

    Point destination = (axis == Axis.vertical)
        ? Point(piece.position.x, target)
        : Point(target, piece.position.y);

    if (destination != piece.position) {
      relocate(
        piece,
        destination,
        index,
      );
    }
  }

  void merge(
    BuildContext context,
    GamePiece source,
    GamePiece? target,
    List<GamePiece> pieces,
    Map<Point, GamePiece> index,
  ) {
    if (source.value == 12) {
      index.remove(source.position);
      index.remove(target!.position);
      pieces.remove(source);
      pieces.remove(target);

      context.read<ColorsSlideBloc>().add(
            UpdateColorsSlideScore(
              reset: false,
              increaseAmount: source.model.value * 100,
            ),
          );
      context.read<ColorsSlideBloc>().add(
            UpdateColorsSlidePieces(
              index: index,
              pieces: pieces,
            ),
          );
      return;
    }

    source.model.value += 1;
    index.remove(target!.position);
    pieces.remove(target);
    relocate(
      source,
      target.position,
      index,
    );

    context.read<ColorsSlideBloc>().add(
          UpdateColorsSlideScore(
            reset: false,
            increaseAmount: source.model.value * 10,
          ),
        );
    context.read<ColorsSlideBloc>().add(
          UpdateColorsSlidePieces(
            index: index,
            pieces: pieces,
          ),
        );
  }

  void relocate(
    GamePiece piece,
    Point destination,
    Map<Point, GamePiece> index,
  ) {
    index.remove(piece.position);
    piece.move(destination);
    index[piece.position] = piece;
  }

  void start(
    BuildContext context,
    int gridSize,
    List<GamePiece> pieces,
    Map<Point, GamePiece> index,
  ) {
    print('cont start');
    pieces = [];
    index = {};

    on(
      context,
      const Offset(1, 0),
      gridSize,
      pieces,
      index,
    );
  }

  void restart(
    BuildContext context,
    int gridSize,
    List<GamePiece> pieces,
    Map<Point, GamePiece> index,
  ) {
    pieces = [];
    index = {};

    context.read<ColorsSlideBloc>().add(
          const UpdateColorsSlideScore(
            reset: true,
            increaseAmount: 0,
          ),
        );

    on(
      context,
      const Offset(1, 0),
      gridSize,
      pieces,
      index,
    );
  }
}
