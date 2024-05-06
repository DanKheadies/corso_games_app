import 'dart:async';

import 'package:corso_games_app/providers/providers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Field extends StatefulWidget {
  final int row;
  final int place;
  final double size;

  const Field({
    Key? key,
    required this.row,
    required this.place,
    required this.size,
  }) : super(key: key);

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  bool disabled = false;

  void handleClick(Function saveChoice, BuildContext context) {
    saveChoice(widget.row, widget.place, context);

    setState(() {
      disabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GameProvider state = context.watch<GameProvider>();

    if (state.restart == true) {
      Future.delayed(Duration.zero, () {
        setState(() {
          disabled = false;
        });
        state.handleRestart();
      });
    }

    final Size size = MediaQuery.of(context).size;
    return Container(
      width: widget.size / 3,
      height: widget.size / 3,
      decoration: BoxDecoration(
        border: state.determineBorder(widget.row, widget.place),
      ),
      child: TextButton(
        onPressed: disabled == true
            ? () {}
            : () => handleClick(state.saveChoice, context),
        child: disabled
            ? (state.movesList[widget.row][widget.place] == 'X'
                ? XSign(
                    shapeSize: size.height * 0.07,
                  )
                : state.movesList[widget.row][widget.place] == 'O'
                    ? Circle(
                        shapeSize: size.height * 0.07,
                      )
                    : const SizedBox())
            : const SizedBox(),
      ),
    );
  }
}
