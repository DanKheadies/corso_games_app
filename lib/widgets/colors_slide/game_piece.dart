import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:corso_games_app/widgets/colors_slide/controller.dart';

class GamePieceModel extends ChangeNotifier {
  GamePieceModel({
    required this.value,
    required this.position,
  }) {
    prev = initialPoint(initialDirection);
  }

  late int value;
  late Point position;
  late Point prev;

  Direction get initialDirection => Controller.lastDirection;

  Point initialPoint(Direction direction) {
    switch (initialDirection) {
      case Direction.up:
        return Point(position.x, 6);

      case Direction.down:
        return Point(position.x, 0);

      case Direction.left:
        return Point(6, position.y);

      case Direction.right:
        return Point(0, position.y);

      case Direction.none:
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

  final Animation<double> x;
  final Animation<double> y;

  final List<Color> colors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    model.prev = model.position;

    Size size = MediaQuery.of(context).size;
    double itemSize = size.width / 7;

    return Align(
      alignment: FractionalOffset(
        x.value / 6,
        y.value / 6,
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
            height: itemSize * .7,
            width: itemSize * .7,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: colors[model.value].withOpacity(0.25),
              // color: Colors.black,
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
  }) : super(key: key);

  final GamePieceModel model;

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
          );
        },
      ),
    );
  }
}
