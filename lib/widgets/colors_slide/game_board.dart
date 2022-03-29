import 'dart:async';
import 'package:flutter/material.dart';
import 'package:corso_games_app/widgets/colors_slide/controller.dart';
import 'package:corso_games_app/widgets/colors_slide/game_piece.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late StreamSubscription _eventStream;
  Offset dragOffset = const Offset(0, 0);

  List<GamePiece> pieces = [];

  void onTurn(dynamic data) {
    setState(() {
      pieces = Controller.pieces;
    });
  }

  void onGesture(DragUpdateDetails ev) {
    dragOffset = Offset(
      (dragOffset.dx + ev.delta.dx) / 2,
      (dragOffset.dy + ev.delta.dy) / 2,
    );
  }

  void onPanEnd(DragEndDetails ev) {
    Controller.on(dragOffset);
  }

  @override
  void initState() {
    super.initState();
    _eventStream = Controller.listen(onTurn);
  }

  @override
  void dispose() {
    super.dispose();
    _eventStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double root = size.width;

    return GestureDetector(
      onPanUpdate: onGesture,
      onPanEnd: onPanEnd,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(
              // color: Colors.cyan.withOpacity(0.4),
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          width: root,
          height: root,
          child: Stack(
            key: UniqueKey(),
            children: pieces,
          ),
        ),
      ),
    );
  }
}
