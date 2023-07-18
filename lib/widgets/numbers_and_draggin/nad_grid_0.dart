// import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:corso_games_app/config/theme.dart';
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

  // double posLeft = 0;
  // double posTop = 0;

  @override
  void initState() {
    super.initState();

    initializeGameBoard();
  }

  void initializeGameBoard() {
    // print('initialize');
    // List<NadGridUnit> grid0 = nadGridData0(
    //   widget.squareSize,
    //   widget.boardPad,
    //   widget.columns,
    //   widget.rows,
    //   'green',
    // );
    nadGridUnits = nadGridData0(
      widget.squareSize,
      widget.boardPad,
      widget.columns,
      widget.rows,
      'green',
    );

    // updateDraggables(grid0);
    // updateDraggables(nadGridUnits);
  }

  // bool canAcceptUnit(String unitId) {
  //   // print('can accept');
  //   return true;
  //   // return selectedGridUnit != unitId;
  //   // return selectedGridUnit != unitId && selectedGridUnit != '';
  // }

  // void updateDraggables(List<NadGridUnit> grid) {
  //   print('update');
  //   nadGridDrags.clear();

  //   for (var unit in grid) {
  //     // print('unit: ${unit.id}');
  //     // print('sgu: $selectedGridUnit');
  //     // print('index: ${grid.indexWhere((u) => u.id == unit.id)}');
  //     // print('left: ${grid[grid.indexWhere((u) => u.id == unit.id)]}');
  //     // print('left+: ${grid[grid.indexWhere((u) => u.id == unit.id)].left}');

  //     nadGridDrags.add(
  //       NadDragObject(
  //         id: unit.id,
  //         left: grid[grid.indexWhere((u) => u.id == unit.id)].left,
  //         top: grid[grid.indexWhere((u) => u.id == unit.id)].top,
  //         size: widget.squareSize,
  //         color: unit.id == '0'
  //             // ? Theme.of(context).colorScheme.tertiary
  //             ? cgGreen1
  //             // : Theme.of(context).colorScheme.background,
  //             : cgYellow,
  //         text: unit.id,
  //         canAccept: selectedGridUnit != unit.id && selectedGridUnit != '',
  //         // canAccept: true,
  //         // canAccept: canAcceptUnit(unit.id),
  //         canDrag: unit.id == '0' ? true : false,
  //         onTapDown: unitSelected,
  //         onTapUp: resetDraggables,
  //         changePositions: changePositions,
  //       ),
  //     );
  //   }
  // }

  void unitSelected(String unit) {
    setState(() {
      selectedGridUnit = unit;
    });
    // updateDraggables(nadGridUnits);
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

    // updateDraggables(nadGridUnits);
  }

  void checkForWin() {
    // bool g2g0to29 = true;
    // bool g2g1to0 = true;
    // print('check');

    List<int> currentOrder = [];
    List<int> list0to29 = List.generate(30, (index) => index);
    // print(list0to29);

    List<int> list1to0 = List.generate(30, (index) {
      int value = index + 1;
      if (value == 30) value = 0;
      return value;
    });
    // print(list1to0);

    for (var unit in nadGridUnits) {
      currentOrder.add(
        int.parse(unit.id),
      );
    }
    // print(currentOrder);

    // for (var unit in nadGridUnits) {
    //   if (nadGridUnits.indexWhere((gu) => gu.id == unit.id).toString() !=
    //       unit.id) {
    //     // if (unit.id)
    //     g2g0to29 = false;
    //   }
    // }

    // for (var unit in nadGridUnits) {
    //   // print((int.parse(unit.id)).toString());
    //   if (nadGridUnits.indexWhere((gu) => gu.id == unit.id).toString() !=
    //       unit.id) {
    //     // if (unit.id)
    //     g2g1to0 = false;
    //   }
    // }

    if (listEquals(list0to29, currentOrder) ||
        listEquals(list1to0, currentOrder)) {
      widget.roundWon();
      // if (listEquals(list0to29, currentOrder)) print('was g2g0to29');
      // if (listEquals(list1to0, currentOrder)) print('was g2g1to0');
    }
  }

  String randomizeGrid(String num) {
    return '';
  }

  // List<NadDragObject> _buildGrid() {
  //   updateDraggables(nadGridUnits);
  //   return nadGridDrags;
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.resetGameBoard) {
      initializeGameBoard();
      widget.unsetReset();
    }

    return Padding(
      padding: EdgeInsets.all(widget.boardPad),
      child: Stack(
        // children: nadGridDrags,
        // children: _buildGrid(),
        children: [
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
        // children: [
        //   NadDragObject(
        //     id: '0',
        //     left: grid[grid.indexWhere((unit) => unit.id == '0')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '0')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '0',
        //     canAccept: selectedGridUnit != '0' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '1',
        //     left: grid[grid.indexWhere((unit) => unit.id == '1')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '1')].top,
        //     size: widget.squareSize,
        //     color: Colors.white,
        //     color: Theme.of(context).colorScheme.tertiary,
        //     text: '',
        //     canAccept: selectedGridUnit != '1' && selectedGridUnit != '',
        //     canDrag: true,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '2',
        //     left: grid[grid.indexWhere((unit) => unit.id == '2')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '2')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '2',
        //     canAccept: selectedGridUnit != '2' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '3',
        //     left: grid[grid.indexWhere((unit) => unit.id == '3')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '3')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '3',
        //     canAccept: selectedGridUnit != '3' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '4',
        //     left: grid[grid.indexWhere((unit) => unit.id == '4')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '4')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '4',
        //     canAccept: selectedGridUnit != '4' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '5',
        //     left: grid[grid.indexWhere((unit) => unit.id == '5')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '5')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '5',
        //     canAccept: selectedGridUnit != '5' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '6',
        //     left: grid[grid.indexWhere((unit) => unit.id == '6')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '6')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '6',
        //     canAccept: selectedGridUnit != '6' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '7',
        //     left: grid[grid.indexWhere((unit) => unit.id == '7')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '7')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '7',
        //     canAccept: selectedGridUnit != '7' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '8',
        //     left: grid[grid.indexWhere((unit) => unit.id == '8')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '8')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '8',
        //     canAccept: selectedGridUnit != '8' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '9',
        //     left: grid[grid.indexWhere((unit) => unit.id == '9')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '9')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '9',
        //     canAccept: selectedGridUnit != '9' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '10',
        //     left: grid[grid.indexWhere((unit) => unit.id == '10')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '10')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '10',
        //     canAccept: selectedGridUnit != '10' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '11',
        //     left: grid[grid.indexWhere((unit) => unit.id == '11')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '11')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '11',
        //     canAccept: selectedGridUnit != '11' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '12',
        //     left: grid[grid.indexWhere((unit) => unit.id == '12')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '12')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '12',
        //     canAccept: selectedGridUnit != '12' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '13',
        //     left: grid[grid.indexWhere((unit) => unit.id == '13')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '13')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '13',
        //     canAccept: selectedGridUnit != '13' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '14',
        //     left: grid[grid.indexWhere((unit) => unit.id == '14')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '14')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '14',
        //     canAccept: selectedGridUnit != '14' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '15',
        //     left: grid[grid.indexWhere((unit) => unit.id == '15')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '15')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '15',
        //     canAccept: selectedGridUnit != '15' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '16',
        //     left: grid[grid.indexWhere((unit) => unit.id == '16')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '16')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '16',
        //     canAccept: selectedGridUnit != '16' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '17',
        //     left: grid[grid.indexWhere((unit) => unit.id == '17')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '17')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '17',
        //     canAccept: selectedGridUnit != '17' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '18',
        //     left: grid[grid.indexWhere((unit) => unit.id == '18')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '18')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '18',
        //     canAccept: selectedGridUnit != '18' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '19',
        //     left: grid[grid.indexWhere((unit) => unit.id == '19')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '19')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '19',
        //     canAccept: selectedGridUnit != '19' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '20',
        //     left: grid[grid.indexWhere((unit) => unit.id == '20')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '20')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '20',
        //     canAccept: selectedGridUnit != '20' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '21',
        //     left: grid[grid.indexWhere((unit) => unit.id == '21')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '21')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '21',
        //     canAccept: selectedGridUnit != '21' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '22',
        //     left: grid[grid.indexWhere((unit) => unit.id == '22')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '22')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '22',
        //     canAccept: selectedGridUnit != '22' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '23',
        //     left: grid[grid.indexWhere((unit) => unit.id == '23')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '23')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '23',
        //     canAccept: selectedGridUnit != '23' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '24',
        //     left: grid[grid.indexWhere((unit) => unit.id == '24')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '24')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '24',
        //     canAccept: selectedGridUnit != '24' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '25',
        //     left: grid[grid.indexWhere((unit) => unit.id == '25')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '25')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '25',
        //     canAccept: selectedGridUnit != '25' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '26',
        //     left: grid[grid.indexWhere((unit) => unit.id == '26')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '26')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '26',
        //     canAccept: selectedGridUnit != '26' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '27',
        //     left: grid[grid.indexWhere((unit) => unit.id == '27')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '27')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '27',
        //     canAccept: selectedGridUnit != '27' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '28',
        //     left: grid[grid.indexWhere((unit) => unit.id == '28')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '28')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '28',
        //     canAccept: selectedGridUnit != '28' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '29',
        //     left: grid[grid.indexWhere((unit) => unit.id == '29')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '29')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '29',
        //     canAccept: selectedGridUnit != '29' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        //   NadDragObject(
        //     id: '30',
        //     left: grid[grid.indexWhere((unit) => unit.id == '30')].left,
        //     top: grid[grid.indexWhere((unit) => unit.id == '30')].top,
        //     size: widget.squareSize,
        //     color: Theme.of(context).colorScheme.background,
        //     text: '30',
        //     canAccept: selectedGridUnit != '30' && selectedGridUnit != '',
        //     canDrag: false,
        //     onTapDown: colorSelected,
        //     onTapUp: resetDraggables,
        //     changePositions: changePositions,
        //   ),
        // ],
      ),
    );
  }
}
