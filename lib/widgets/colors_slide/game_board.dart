import 'dart:async';
import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:corso_games_app/widgets/colors_slide/controller.dart';
import 'package:corso_games_app/widgets/colors_slide/game_piece.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    Key? key,
    required this.pieces,
    required this.cont,
    required this.gridSize,
    required this.index,
  }) : super(key: key);

  final List<GamePiece> pieces;
  final Controller cont;
  final int gridSize;
  final Map<Point, GamePiece> index;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Offset dragOffset = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    // TODO: disable this
    // widget.cont.start(
    //   context,
    //   widget.gridSize,
    //   widget.pieces,
    //   widget.index,
    // );
  }

  void onGesture(DragUpdateDetails ev) {
    dragOffset = Offset(
      (dragOffset.dx + ev.delta.dx) / 2,
      (dragOffset.dy + ev.delta.dy) / 2,
    );
  }

  void onPanEnd(DragEndDetails ev) {
    widget.cont.on(
      context,
      dragOffset,
      widget.gridSize,
      widget.pieces,
      widget.index,
    );
    Timer(
      const Duration(milliseconds: 300),
      () => dragOffset = const Offset(0, 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double root = size.width;

    return GestureDetector(
      onPanUpdate: onGesture,
      onPanEnd: onPanEnd,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 10,
              intensity: 0.75,
              surfaceIntensity: 0.25,
              lightSource: LightSource.topLeft,
              color: Theme.of(context).scaffoldBackgroundColor,
              shadowDarkColor:
                  Theme.of(context).colorScheme.surface.withOpacity(0.575),
              shadowDarkColorEmboss:
                  Theme.of(context).colorScheme.surface.withOpacity(0.575),
              shadowLightColor:
                  Theme.of(context).colorScheme.background.withOpacity(0.575),
              shadowLightColorEmboss:
                  Theme.of(context).colorScheme.background.withOpacity(0.575),
            ),
            child: SizedBox(
              width: root,
              height: root,
              child: Stack(
                key: UniqueKey(),
                children: widget.pieces,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
