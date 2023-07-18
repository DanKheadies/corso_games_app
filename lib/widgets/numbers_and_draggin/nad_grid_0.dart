import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:corso_games_app/data/data.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class NadGrid0 extends StatefulWidget {
  final double boardPad;
  final double gridWidth;
  final double squareSize;
  final int columns;
  final int rows;
  final bool resetGameBoard;
  final VoidCallback unsetReset;
  final VoidCallback roundWon;

  const NadGrid0({
    super.key,
    required this.boardPad,
    required this.gridWidth,
    required this.squareSize,
    required this.columns,
    required this.rows,
    required this.resetGameBoard,
    required this.unsetReset,
    required this.roundWon,
  });

  @override
  State<NadGrid0> createState() => _NadGrid0State();
}

class _NadGrid0State extends State<NadGrid0> {
  double touchOpac = 1;
  String selectedGridUnit = '';
  bool isNumbers = true;

  List<NadDragObject> nadGridDrags = [];
  List<NadGridUnit> nadGridUnits = [];

  @override
  void initState() {
    super.initState();

    initializeGameBoard();
  }

  void initializeGameBoard() {
    nadGridUnits = nadGridData0(
      widget.squareSize,
      widget.boardPad,
      widget.columns,
      widget.rows,
      'green',
    );
  }

  void unitSelected(String unit) {
    setState(() {
      selectedGridUnit = unit;
    });
  }

  void resetDraggables(String id) {
    setState(() {
      selectedGridUnit = '';
    });

    // Check winner
    checkForWin();
  }

  void changePositions(
    Object invading,
    String retreating,
  ) {
    int invIndex = nadGridUnits.indexWhere((unit) => unit.id == invading);
    String invId = nadGridUnits[invIndex].id;
    double invLeft = nadGridUnits[invIndex].left;
    double invTop = nadGridUnits[invIndex].top;

    int retIndex = nadGridUnits.indexWhere((unit) => unit.id == retreating);
    String retId = nadGridUnits[retIndex].id;
    double retLeft = nadGridUnits[retIndex].left;
    double retTop = nadGridUnits[retIndex].top;

    setState(() {
      nadGridUnits[invIndex] = NadGridUnit(
        id: retId,
        left: invLeft,
        top: invTop,
      );
      nadGridUnits[retIndex] = NadGridUnit(
        id: invId,
        left: retLeft,
        top: retTop,
      );
    });
  }

  void checkForWin() {
    List<int> currentOrder = [];
    List<int> list0to29 = List.generate(30, (index) => index);

    List<int> list1to0 = List.generate(30, (index) {
      int value = index + 1;
      if (value == 30) value = 0;
      return value;
    });

    for (var unit in nadGridUnits) {
      currentOrder.add(
        int.parse(unit.id),
      );
    }

    if (listEquals(list0to29, currentOrder) ||
        listEquals(list1to0, currentOrder)) {
      widget.roundWon();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.resetGameBoard) {
      initializeGameBoard();
      widget.unsetReset();
    }

    return Padding(
      padding: EdgeInsets.all(widget.boardPad),
      child: Stack(
        children: [
          // TODO: can this be procedurally generated to account for different col & row #
          NadDragObject(
            id: '0',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '0')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '0')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.tertiary,
            text: '0',
            canAccept: selectedGridUnit != '0' && selectedGridUnit != '',
            canDrag: true,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '1',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '1')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '1')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '1',
            canAccept: selectedGridUnit != '1' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '2',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '2')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '2')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '2',
            canAccept: selectedGridUnit != '2' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '3',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '3')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '3')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '3',
            canAccept: selectedGridUnit != '3' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '4',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '4')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '4')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '4',
            canAccept: selectedGridUnit != '4' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '5',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '5')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '5')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '5',
            canAccept: selectedGridUnit != '5' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '6',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '6')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '6')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '6',
            canAccept: selectedGridUnit != '6' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '7',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '7')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '7')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '7',
            canAccept: selectedGridUnit != '7' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '8',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '8')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '8')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '8',
            canAccept: selectedGridUnit != '8' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '9',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '9')]
                    .left,
            top: nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '9')]
                .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '9',
            canAccept: selectedGridUnit != '9' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '10',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '10')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '10')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '10',
            canAccept: selectedGridUnit != '10' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '11',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '11')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '11')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '11',
            canAccept: selectedGridUnit != '11' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '12',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '12')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '12')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '12',
            canAccept: selectedGridUnit != '12' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '13',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '13')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '13')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '13',
            canAccept: selectedGridUnit != '13' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '14',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '14')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '14')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '14',
            canAccept: selectedGridUnit != '14' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '15',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '15')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '15')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '15',
            canAccept: selectedGridUnit != '15' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '16',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '16')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '16')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '16',
            canAccept: selectedGridUnit != '16' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '17',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '17')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '17')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '17',
            canAccept: selectedGridUnit != '17' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '18',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '18')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '18')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '18',
            canAccept: selectedGridUnit != '18' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '19',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '19')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '19')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '19',
            canAccept: selectedGridUnit != '19' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '20',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '20')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '20')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '20',
            canAccept: selectedGridUnit != '20' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '21',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '21')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '21')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '21',
            canAccept: selectedGridUnit != '21' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '22',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '22')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '22')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '22',
            canAccept: selectedGridUnit != '22' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '23',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '23')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '23')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '23',
            canAccept: selectedGridUnit != '23' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '24',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '24')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '24')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '24',
            canAccept: selectedGridUnit != '24' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '25',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '25')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '25')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '25',
            canAccept: selectedGridUnit != '25' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '26',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '26')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '26')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '26',
            canAccept: selectedGridUnit != '26' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '27',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '27')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '27')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '27',
            canAccept: selectedGridUnit != '27' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '28',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '28')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '28')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '28',
            canAccept: selectedGridUnit != '28' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          NadDragObject(
            id: '29',
            left:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '29')]
                    .left,
            top:
                nadGridUnits[nadGridUnits.indexWhere((unit) => unit.id == '29')]
                    .top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '29',
            canAccept: selectedGridUnit != '29' && selectedGridUnit != '',
            canDrag: false,
            onTapDown: unitSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
        ],
      ),
    );
  }
}
