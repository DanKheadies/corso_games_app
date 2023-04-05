import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';

ColorsSlideDirection lastDirection = ColorsSlideDirection.right;

class ColorsController {
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
    ColorsGamePiece piece,
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
  ) {
    // print('add piece @ ${piece.position}');
    colorsPieces.add(piece);
    index[piece.position] = piece;

    // colorsPieces.forEach((element) {
    //   print(element.model.position);
    // });
    // index.forEach((key, value) {
    //   print(key);
    // });

    context.read<ColorsSlideBloc>().add(
          const UpdateColorsSlideScore(
            colorsReset: false,
            colorsIncreaseAmount: 1,
          ),
        );
    // print('updating colorsPieces via add');
    context.read<ColorsSlideBloc>().add(
          UpdateColorsSlidePieces(
            colorsIndexMap: index,
            colorsPieces: colorsPieces,
          ),
        );
  }

  // Handles moving / combining / etc colorsPieces using the user input
  void on(
    BuildContext context,
    Offset offset,
    int gridSize,
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
  ) {
    // Identifies a Direction (or lack thereof)
    lastDirection = parse(offset);

    // Decides how to push / merge colorsPieces and add a new  one
    process(
      context,
      lastDirection,
      gridSize,
      colorsPieces,
      index,
    );

    // Needed to make the colorsPieces appear / happen
    bus.add(null);

    // No more room at the inn
    if (colorsPieces.length == (gridSize * gridSize)) {
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
      ColorsGamePiece(
        model: ColorsGamePieceModel(
          position: p,
          value: 0,
          gridSize: gridSize,
        ),
        gridSize: gridSize,
      ),
      colorsPieces,
      index,
    );
  }

  void process(
    BuildContext context,
    ColorsSlideDirection direction,
    int gridSize,
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
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
          colorsPieces,
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
          colorsPieces,
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
          colorsPieces,
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
          colorsPieces,
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
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
  ) {
    for (int j = start; j != end; j += op) {
      for (int k = 0; k != gridSize; k++) {
        Point p = axis == Axis.vertical ? Point(k, j) : Point(j, k);
        if (index.containsKey(p)) {
          check(
            context,
            axis,
            index[p]!,
            start,
            op,
            colorsPieces,
            index,
          );
        }
      }
    }
  }

  void check(
    BuildContext context,
    Axis axis,
    ColorsGamePiece piece,
    int start,
    int op,
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
  ) {
    num target = (axis == Axis.vertical) ? piece.position.y : piece.position.x;
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
          colorsPieces,
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
        context,
        piece,
        destination,
        colorsPieces,
        index,
      );
    }

    // print('this should fix it?');
    // context.read<ColorsSlideBloc>().add(
    //       UpdateColorsSlidePieces(
    //         index: index,
    //         colorsPieces: colorsPieces,
    //       ),
    //     );
  }

  void merge(
    BuildContext context,
    ColorsGamePiece source,
    ColorsGamePiece? target,
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
  ) {
    if (source.value == 12) {
      index.remove(source.position);
      index.remove(target!.position);
      colorsPieces.remove(source);
      colorsPieces.remove(target);

      context.read<ColorsSlideBloc>().add(
            UpdateColorsSlideScore(
              colorsReset: false,
              colorsIncreaseAmount: source.model.value * 100,
            ),
          );
      context.read<ColorsSlideBloc>().add(
            UpdateColorsSlidePieces(
              colorsIndexMap: index,
              colorsPieces: colorsPieces,
            ),
          );
      return;
    }

    // Check if the target matches one in colorsPieces
    var inderp = colorsPieces
        .indexWhere((element) => element.position == target!.position);

    // A match means we need to update colorsPieces list / bloc cache
    if (inderp != -1) {
      colorsPieces[inderp] = target!;
    }

    source.model.value += 1;
    index.remove(target!.position);
    colorsPieces.remove(target);

    relocate(
      context,
      source,
      target.position,
      colorsPieces,
      index,
    );

    context.read<ColorsSlideBloc>().add(
          UpdateColorsSlideScore(
            colorsReset: false,
            colorsIncreaseAmount: source.model.value * 10,
          ),
        );
    context.read<ColorsSlideBloc>().add(
          UpdateColorsSlidePieces(
            colorsIndexMap: index,
            colorsPieces: colorsPieces,
          ),
        );
  }

  void relocate(
    BuildContext context,
    ColorsGamePiece piece,
    Point destination,
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
  ) {
    // Check if the piece matches one in colorsPieces
    var inderp = colorsPieces
        .indexWhere((element) => element.position == piece.position);

    // A match means we need to update colorsPieces list / bloc cache
    if (inderp != -1) {
      colorsPieces[inderp] = piece;
    }

    // Relocate the colorsPieces
    index.remove(piece.position);
    piece.move(destination);
    index[piece.position] = piece;
  }

  void start(
    BuildContext context,
    int gridSize,
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
  ) {
    colorsPieces = [];
    index = {};

    on(
      context,
      const Offset(1, 0),
      gridSize,
      colorsPieces,
      index,
    );
  }

  void restart(
    BuildContext context,
    int gridSize,
    List<ColorsGamePiece> colorsPieces,
    Map<Point, ColorsGamePiece> index,
  ) {
    colorsPieces = [];
    index = {};

    context.read<ColorsSlideBloc>().add(
          const UpdateColorsSlideScore(
            colorsReset: true,
            colorsIncreaseAmount: 0,
          ),
        );

    on(
      context,
      const Offset(1, 0),
      gridSize,
      colorsPieces,
      index,
    );
  }
}
