import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GameGridCore extends StatefulWidget {
  final double boardPad;
  final double gridWidth;
  final double squareSize;
  final bool canDrag;
  final bool resetGameBoard;
  final Function(String) colorSelected;
  final Function(String) resetDraggables;
  final Function(Object, String) changePositions;
  final List<GridUnit> grid;
  final String selectedGridUnit;
  final VoidCallback unsetReset;
  final VoidCallback turnsTicker;
  final VoidCallback roundWon;

  const GameGridCore({
    super.key,
    required this.boardPad,
    required this.gridWidth,
    required this.squareSize,
    required this.canDrag,
    required this.resetGameBoard,
    required this.colorSelected,
    required this.resetDraggables,
    required this.changePositions,
    required this.grid,
    required this.selectedGridUnit,
    required this.unsetReset,
    required this.turnsTicker,
    required this.roundWon,
  });

  @override
  State<GameGridCore> createState() => _GameGridCoreState();
}

class _GameGridCoreState extends State<GameGridCore> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.boardPad),
      child: Stack(
        children: [
          DragObject(
            id: '1',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '1')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '1')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '1',
            canAccept:
                widget.selectedGridUnit != '1' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '2',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '2')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '2')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.tertiary,
            text: '2',
            canAccept:
                widget.selectedGridUnit != '2' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '3',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '3')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '3')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '3',
            canAccept:
                widget.selectedGridUnit != '3' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '4',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '4')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '4')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '4',
            canAccept:
                widget.selectedGridUnit != '4' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '5',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '5')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '5')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '5',
            canAccept:
                widget.selectedGridUnit != '5' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '6',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '6')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '6')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.tertiary,
            text: '6',
            canAccept:
                widget.selectedGridUnit != '6' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '7',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '7')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '7')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '7',
            canAccept:
                widget.selectedGridUnit != '7' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '8',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '8')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '8')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '8',
            canAccept:
                widget.selectedGridUnit != '8' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '9',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '9')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '9')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.tertiary,
            text: '9',
            canAccept:
                widget.selectedGridUnit != '9' && widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '10',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '10')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '10')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '10',
            canAccept: widget.selectedGridUnit != '10' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '11',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '11')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '11')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '11',
            canAccept: widget.selectedGridUnit != '11' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '12',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '12')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '12')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '12',
            canAccept: widget.selectedGridUnit != '12' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '13',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '13')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '13')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '13',
            canAccept: widget.selectedGridUnit != '13' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '14',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '14')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '14')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '14',
            canAccept: widget.selectedGridUnit != '14' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '15',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '15')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '15')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.tertiary,
            text: '15',
            canAccept: widget.selectedGridUnit != '15' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '16',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '16')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '16')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '16',
            canAccept: widget.selectedGridUnit != '16' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '17',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '17')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '17')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '17',
            canAccept: widget.selectedGridUnit != '17' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '18',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '18')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '18')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '18',
            canAccept: widget.selectedGridUnit != '18' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '19',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '19')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '19')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '19',
            canAccept: widget.selectedGridUnit != '19' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '20',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '20')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '20')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '20',
            canAccept: widget.selectedGridUnit != '20' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '21',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '21')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '21')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '21',
            canAccept: widget.selectedGridUnit != '21' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '22',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '22')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '22')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '22',
            canAccept: widget.selectedGridUnit != '22' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '23',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '23')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '23')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '23',
            canAccept: widget.selectedGridUnit != '23' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '24',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '24')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '24')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.tertiary,
            text: '24',
            canAccept: widget.selectedGridUnit != '24' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '25',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '25')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '25')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '25',
            canAccept: widget.selectedGridUnit != '25' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '26',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '26')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '26')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '26',
            canAccept: widget.selectedGridUnit != '26' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '27',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '27')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '27')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.tertiary,
            text: '27',
            canAccept: widget.selectedGridUnit != '27' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '28',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '28')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '28')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '28',
            canAccept: widget.selectedGridUnit != '28' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '29',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '29')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '29')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '29',
            canAccept: widget.selectedGridUnit != '29' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
          DragObject(
            id: '30',
            left: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '30')].left,
            top: widget
                .grid[widget.grid.indexWhere((unit) => unit.id == '30')].top,
            size: widget.squareSize,
            color: Theme.of(context).colorScheme.onSurface,
            text: '30',
            canAccept: widget.selectedGridUnit != '30' &&
                widget.selectedGridUnit != '',
            canDrag: widget.canDrag,
            onTapDown: widget.colorSelected,
            onTapUp: widget.resetDraggables,
            changePositions: widget.changePositions,
          ),
        ],
      ),
    );
  }
}
