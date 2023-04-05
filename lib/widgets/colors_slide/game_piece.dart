import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class GamePieceModel extends ChangeNotifier {
  final int gridSize;

  GamePieceModel({
    required this.value,
    required this.position,
    required this.gridSize,
  }) {
    prev = initialPoint(lastDirection);
  }

  late int value;
  late Point position;
  late Point prev;

  Point initialPoint(ColorsSlideDirection direction) {
    switch (lastDirection) {
      case ColorsSlideDirection.up:
        return Point(position.x, gridSize - 1);

      case ColorsSlideDirection.down:
        return Point(position.x, 0);

      case ColorsSlideDirection.left:
        return Point(gridSize - 1, position.y);

      case ColorsSlideDirection.right:
        return Point(0, position.y);

      case ColorsSlideDirection.none:
        break;
    }

    return const Point(0, 0);
  }

  void move(Point to) {
    prev = position;
    position = to;
    notifyListeners();
  }
}

class GamePieceView extends AnimatedWidget {
  GamePieceView({
    Key? key,
    required this.model,
    controller,
    required this.gridSize,
  })  : x = Tween<double>(
          begin: model.prev.x.toDouble(),
          end: model.position.x.toDouble(),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.100,
              curve: Curves.ease,
            ),
          ),
        ),
        y = Tween<double>(
          begin: model.prev.y.toDouble(),
          end: model.position.y.toDouble(),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.100,
              curve: Curves.ease,
            ),
          ),
        ),
        super(
          key: key,
          listenable: controller,
        );

  final GamePieceModel model;
  AnimationController get controller => listenable as AnimationController;
  final int gridSize;

  final Animation<double> x;
  final Animation<double> y;

  final List<Color> colors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.black,
    Colors.pinkAccent,
    Colors.lime,
    Colors.teal,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    model.prev = model.position;

    Size size = MediaQuery.of(context).size;
    double itemSize = size.width / gridSize;

    return Align(
      alignment: FractionalOffset(
        x.value / (gridSize - 1),
        y.value / (gridSize - 1),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: itemSize,
          maxWidth: itemSize,
        ),
        height: itemSize,
        width: itemSize,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: itemSize * .8, // .7   (model.gridSize / 10)
            width: itemSize * .8, // .7   (model.gridSize / 10)
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: colors[model.value].withOpacity(0.5),
              border: Border.all(
                color: colors[model.value],
                width: 1,
              ),
              borderRadius: BorderRadius.circular(itemSize / 2),
            ),
          ),
        ),
      ),
    );
  }
}

class GamePiece extends StatefulWidget {
  const GamePiece({
    Key? key,
    required this.model,
    required this.gridSize,
  }) : super(key: key);

  final GamePieceModel model;
  final int gridSize;

  int get value => model.value;
  Point get position => model.position;
  void move(Point to) => model.move(to);

  @override
  State<GamePiece> createState() => _GamePieceState();
}

class _GamePieceState extends State<GamePiece> with TickerProviderStateMixin {
  _GamePieceState();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.model,
      child: Consumer<GamePieceModel>(
        builder: (
          context,
          model,
          child,
        ) {
          try {
            _controller.reset();
            _controller.forward();
          } on TickerCanceled {}

          return GamePieceView(
            model: model,
            controller: _controller,
            gridSize: widget.gridSize,
          );
        },
      ),
    );
  }
}
