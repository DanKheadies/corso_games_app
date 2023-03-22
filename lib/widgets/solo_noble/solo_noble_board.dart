import 'package:flutter/material.dart';

import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class SoloNobleBoard extends StatefulWidget {
  final SoloNobleBuilder builder;

  const SoloNobleBoard({
    super.key,
    required this.builder,
  });

  @override
  State<SoloNobleBoard> createState() => _SoloNobleBoardState();
}

class _SoloNobleBoardState extends State<SoloNobleBoard> {
  bool isGameOver = false;
  bool isPegBeingDragged = false;
  bool isPegDroppableOnTheHoleBelow = false;
  BoardFactory boardFactory = BoardFactory();

  late BoardConfiguration boardConfiguration;
  late Index indexOfPegBeingDragged;

  @override
  void initState() {
    super.initState();
    boardConfiguration = boardFactory.get(0);
  }

  Widget buildHoleAtIndex(
    Index holeIndex,
    Size size,
    BuildContext context,
  ) {
    return DragTarget<Index>(
      builder: (
        context,
        candidateData,
        rejectedData,
      ) {
        Color color = Theme.of(context).colorScheme.secondary;
        if (isPegBeingDragged) {
          if (holeIndex == indexOfPegBeingDragged) {
            color = isPegDroppableOnTheHoleBelow ? Colors.pink : Colors.teal;
          }
        }
        return Hole(
          index: holeIndex,
          size: size,
          color: color,
        );
      },
      onWillAccept: (pegIndex) {
        bool isPegDroppableInHole =
            boardConfiguration.checkIfPegIsDroppableInHole(
          pegIndex ?? Index(0, 0),
          holeIndex,
        );

        if (isPegDroppableInHole) {
          setState(() {
            indexOfPegBeingDragged = holeIndex;
            isPegBeingDragged = true;
            isPegDroppableOnTheHoleBelow = true;
          });
        } else {
          setState(() {
            indexOfPegBeingDragged = holeIndex;
            isPegBeingDragged = true;
            isPegDroppableOnTheHoleBelow = false;
          });
        }

        return isPegDroppableInHole;
      },
      onLeave: (pegIndex) {
        setState(() {
          isPegBeingDragged = false;
        });
      },
      onAccept: (pegIndex) {
        // print('Peg inserted at $pegIndex.');
        int pegToRemoveRow = (pegIndex.row + holeIndex.row) ~/ 2;
        int pegToRemoveColumn = (pegIndex.column + holeIndex.column) ~/ 2;

        setState(() {
          boardConfiguration.pegs[pegIndex.row][pegIndex.column] = false;
          boardConfiguration.pegs[pegToRemoveRow][pegToRemoveColumn] = false;
          boardConfiguration.pegs[holeIndex.row][holeIndex.column] = true;
          isPegBeingDragged = false;

          isGameOver = boardConfiguration.checkGameOver();
          if (isGameOver) {
            print('Game Over!');
            // popup w/ WIN or LOSE
            // check if bc.pegs[4][4] is the only true FTW
            // } else {
            // print('Waiting for next move..');
          }
        });
      },
    );
  }

  Hole buildHoleWithPegAtIndex(
    Index holeIndex,
    Size size,
  ) {
    double reduceFactor = 0.8;
    Size pegSize = Size(
      size.width * reduceFactor,
      size.height * reduceFactor,
    );

    return Hole(
      index: holeIndex,
      size: size,
      color: isGameOver
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.secondary,
      peg: Peg(
        index: holeIndex,
        size: pegSize,
      ),
    );
  }

  Widget buildBoxAtIndex(
    Index index,
    Size size,
    BuildContext context,
  ) {
    bool isHole = boardConfiguration.holes[index.row][index.column];
    bool hasPeg = boardConfiguration.pegs[index.row][index.column];

    Widget nothing = SizedBox.fromSize(size: size);

    return isHole
        ? hasPeg
            ? buildHoleWithPegAtIndex(index, size)
            : buildHoleAtIndex(
                index,
                size,
                context,
              )
        : nothing;
  }

  void resetBoard() {
    setState(() {
      boardConfiguration = boardFactory.get(0);
      isGameOver = false;
    });
  }

  Widget buildBoard(Size size) {
    Size boxSize = Size(
      size.width / boardConfiguration.numberOfColumns,
      size.height / boardConfiguration.numberOfRows,
    );

    List<Row> rows = [Row(), Row(), Row(), Row(), Row(), Row(), Row()];
    for (int rowIndex = 0;
        rowIndex < boardConfiguration.numberOfRows;
        rowIndex++) {
      List<Widget> widgets = [
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
        const SizedBox(),
      ];
      for (int columnIndex = 0;
          columnIndex < boardConfiguration.numberOfColumns;
          columnIndex++) {
        widgets[columnIndex] = buildBoxAtIndex(
          Index(rowIndex, columnIndex),
          boxSize,
          context,
        );
      }

      rows[rowIndex] = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows,
    );
  }

  Widget buildLayout(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    const reduceFactor = 0.9;
    Size size = Size.square((constraints.maxWidth < constraints.maxHeight)
        ? constraints.maxWidth * reduceFactor
        : constraints.maxHeight * reduceFactor);
    return buildBoard(size);
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, resetBoard);
    return LayoutBuilder(
      builder: buildLayout,
    );
  }
}
