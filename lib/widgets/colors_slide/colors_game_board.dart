import 'dart:async';
import 'dart:math';

import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ColorsGameBoard extends StatefulWidget {
  const ColorsGameBoard({
    Key? key,
    required this.pieces,
    required this.cont,
    required this.gridSize,
    required this.index,
  }) : super(key: key);

  final List<ColorsGamePiece> pieces;
  final ColorsController cont;
  final int gridSize;
  final Map<Point, ColorsGamePiece> index;

  @override
  State<ColorsGameBoard> createState() => _ColorsGameBoardState();
}

class _ColorsGameBoardState extends State<ColorsGameBoard> {
  Offset dragOffset = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    if (widget.pieces.isEmpty) {
      widget.cont.start(
        context,
        widget.gridSize,
        widget.pieces,
        widget.index,
      );
    }
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
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.575),
              shadowLightColorEmboss:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.575),
            ),
            child: SizedBox(
              width:
                  Responsive.isMobile(context) || Responsive.isTablet(context)
                      ? root
                      : 750,
              height:
                  Responsive.isMobile(context) || Responsive.isTablet(context)
                      ? root
                      : 750,
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
