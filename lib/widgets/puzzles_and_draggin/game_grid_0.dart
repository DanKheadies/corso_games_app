import 'package:corso_games_app/data/data.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GameGrid0 extends StatefulWidget {
  final double boardPad;
  final double gridWidth;
  final double squareSize;
  final bool resetGameBoard;
  final VoidCallback unsetReset;
  final VoidCallback turnsTicker;
  final VoidCallback roundWon;

  const GameGrid0({
    super.key,
    required this.boardPad,
    required this.gridWidth,
    required this.squareSize,
    required this.resetGameBoard,
    required this.unsetReset,
    required this.turnsTicker,
    required this.roundWon,
  });

  @override
  State<GameGrid0> createState() => _GameGrid0State();
}

class _GameGrid0State extends State<GameGrid0> {
  double touchOpac = 1;
  String selectedGridUnit = '';
  bool canDrag = true;
  bool isNumbers = true;

  List<GridUnit> grid = [];

  double posLeft = 0;
  double posTop = 0;

  @override
  void initState() {
    super.initState();

    initializeGameBoard();
  }

  void initializeGameBoard() {
    grid = grid0(
      posLeft,
      posTop,
      widget.squareSize,
      widget.boardPad,
    );
  }

  void colorSelected(String unit) {
    setState(() {
      selectedGridUnit = unit;
    });
  }

  void resetDraggables(String id) {
    setState(() {
      selectedGridUnit = '';
    });

    widget.turnsTicker();

    // Check winner
    checkForWin();
  }

  void changePositions(
    Object invading,
    String retreating,
  ) {
    int invIndex = grid.indexWhere((unit) => unit.id == invading);
    String invId = grid[invIndex].id;
    double invLeft = grid[invIndex].left;
    double invTop = grid[invIndex].top;

    int retIndex = grid.indexWhere((unit) => unit.id == retreating);
    String retId = grid[retIndex].id;
    double retLeft = grid[retIndex].left;
    double retTop = grid[retIndex].top;

    setState(() {
      grid[invIndex] = GridUnit(
        id: retId,
        left: invLeft,
        top: invTop,
      );
      grid[retIndex] = GridUnit(
        id: invId,
        left: retLeft,
        top: retTop,
      );
    });
  }

  void checkForWin() {
    // string is white; int is winning spaces
    if (grid.indexWhere((gu) => gu.id == '1') == 29) {
      widget.roundWon();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.resetGameBoard) {
      initializeGameBoard();
      widget.unsetReset();
    }

    // return GameGridCore(
    //   boardPad: widget.boardPad,
    //   gridWidth: widget.gridWidth,
    //   squareSize: widget.squareSize,
    //   canDrag: canDrag,
    //   resetGameBoard: widget.resetGameBoard,
    //   colorSelected: colorSelected,
    //   resetDraggables: resetDraggables,
    //   changePositions: changePositions,
    //   grid: grid,
    //   selectedGridUnit: selectedGridUnit,
    //   unsetReset: widget.unsetReset,
    //   turnsTicker: widget.turnsTicker,
    //   roundWon: widget.roundWon,
    // );
    return Padding(
      padding: EdgeInsets.all(widget.boardPad),
      child: Stack(
        children: [
          DragObject(
            id: '1',
            left: grid[grid.indexWhere((unit) => unit.id == '1')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '1')].top,
            size: widget.squareSize,
            // color: Colors.white,
            color: Theme.of(context).colorScheme.tertiary,
            text: '1',
            canAccept: selectedGridUnit != '1' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '2',
            left: grid[grid.indexWhere((unit) => unit.id == '2')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '2')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '2',
            canAccept: selectedGridUnit != '2' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '3',
            left: grid[grid.indexWhere((unit) => unit.id == '3')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '3')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '3',
            canAccept: selectedGridUnit != '3' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '4',
            left: grid[grid.indexWhere((unit) => unit.id == '4')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '4')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '4',
            canAccept: selectedGridUnit != '4' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '5',
            left: grid[grid.indexWhere((unit) => unit.id == '5')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '5')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '5',
            canAccept: selectedGridUnit != '5' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '6',
            left: grid[grid.indexWhere((unit) => unit.id == '6')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '6')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '6',
            canAccept: selectedGridUnit != '6' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '7',
            left: grid[grid.indexWhere((unit) => unit.id == '7')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '7')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '7',
            canAccept: selectedGridUnit != '7' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '8',
            left: grid[grid.indexWhere((unit) => unit.id == '8')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '8')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '8',
            canAccept: selectedGridUnit != '8' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '9',
            left: grid[grid.indexWhere((unit) => unit.id == '9')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '9')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '9',
            canAccept: selectedGridUnit != '9' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '10',
            left: grid[grid.indexWhere((unit) => unit.id == '10')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '10')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '10',
            canAccept: selectedGridUnit != '10' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '11',
            left: grid[grid.indexWhere((unit) => unit.id == '11')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '11')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '11',
            canAccept: selectedGridUnit != '11' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '12',
            left: grid[grid.indexWhere((unit) => unit.id == '12')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '12')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '12',
            canAccept: selectedGridUnit != '12' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '13',
            left: grid[grid.indexWhere((unit) => unit.id == '13')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '13')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '13',
            canAccept: selectedGridUnit != '13' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '14',
            left: grid[grid.indexWhere((unit) => unit.id == '14')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '14')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '14',
            canAccept: selectedGridUnit != '14' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '15',
            left: grid[grid.indexWhere((unit) => unit.id == '15')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '15')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '15',
            canAccept: selectedGridUnit != '15' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '16',
            left: grid[grid.indexWhere((unit) => unit.id == '16')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '16')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '16',
            canAccept: selectedGridUnit != '16' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '17',
            left: grid[grid.indexWhere((unit) => unit.id == '17')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '17')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '17',
            canAccept: selectedGridUnit != '17' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '18',
            left: grid[grid.indexWhere((unit) => unit.id == '18')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '18')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '18',
            canAccept: selectedGridUnit != '18' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '19',
            left: grid[grid.indexWhere((unit) => unit.id == '19')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '19')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '19',
            canAccept: selectedGridUnit != '19' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '20',
            left: grid[grid.indexWhere((unit) => unit.id == '20')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '20')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '20',
            canAccept: selectedGridUnit != '20' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '21',
            left: grid[grid.indexWhere((unit) => unit.id == '21')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '21')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '21',
            canAccept: selectedGridUnit != '21' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '22',
            left: grid[grid.indexWhere((unit) => unit.id == '22')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '22')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '22',
            canAccept: selectedGridUnit != '22' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '23',
            left: grid[grid.indexWhere((unit) => unit.id == '23')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '23')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '23',
            canAccept: selectedGridUnit != '23' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '24',
            left: grid[grid.indexWhere((unit) => unit.id == '24')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '24')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '24',
            canAccept: selectedGridUnit != '24' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '25',
            left: grid[grid.indexWhere((unit) => unit.id == '25')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '25')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '25',
            canAccept: selectedGridUnit != '25' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '26',
            left: grid[grid.indexWhere((unit) => unit.id == '26')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '26')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '26',
            canAccept: selectedGridUnit != '26' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '27',
            left: grid[grid.indexWhere((unit) => unit.id == '27')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '27')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '27',
            canAccept: selectedGridUnit != '27' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '28',
            left: grid[grid.indexWhere((unit) => unit.id == '28')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '28')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '28',
            canAccept: selectedGridUnit != '28' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '29',
            left: grid[grid.indexWhere((unit) => unit.id == '29')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '29')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '29',
            canAccept: selectedGridUnit != '29' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
          DragObject(
            id: '30',
            left: grid[grid.indexWhere((unit) => unit.id == '30')].left,
            top: grid[grid.indexWhere((unit) => unit.id == '30')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.background,
            text: '30',
            canAccept: selectedGridUnit != '30' && selectedGridUnit != '',
            canDrag: canDrag,
            onTapDown: colorSelected,
            onTapUp: resetDraggables,
            changePositions: changePositions,
          ),
        ],
      ),
    );
  }
}
