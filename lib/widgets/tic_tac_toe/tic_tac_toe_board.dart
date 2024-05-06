import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TicTacToeBoard extends StatelessWidget {
  const TicTacToeBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double boardSize =
        (Responsive.isMobile(context) ? size.width : 600) * 0.75;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.1),
      width: boardSize,
      height: boardSize,
      child: Column(
        children: [
          Row(
            children: [
              Field(row: 0, place: 0, size: boardSize),
              Field(row: 0, place: 1, size: boardSize),
              Field(row: 0, place: 2, size: boardSize),
            ],
          ),
          Row(
            children: [
              Field(row: 1, place: 0, size: boardSize),
              Field(row: 1, place: 1, size: boardSize),
              Field(row: 1, place: 2, size: boardSize),
            ],
          ),
          Row(
            children: [
              Field(row: 2, place: 0, size: boardSize),
              Field(row: 2, place: 1, size: boardSize),
              Field(row: 2, place: 2, size: boardSize),
            ],
          ),
        ],
      ),
    );
  }
}
