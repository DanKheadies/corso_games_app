import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FoxAndGeeseBoard extends StatefulWidget {
  final SoloNobleBuilder builder;

  const FoxAndGeeseBoard({
    super.key,
    required this.builder,
  });

  @override
  State<FoxAndGeeseBoard> createState() => _FoxAndGeeseBoardState();
}

class _FoxAndGeeseBoardState extends State<FoxAndGeeseBoard> {
  bool isGameOver = false;
  bool isPegBeingDragged = false;
  bool isPegDroppableOnTheHoleBelow = false;
  FeeseFactory feeseFactory = FeeseFactory();

  late FeeseConfiguration feeseConfiguration;
  late Ingex ingexOfPegBeingDragged;

  @override
  void initState() {
    super.initState();

    feeseConfiguration = feeseFactory.get(0);
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, resetBoard);
    return LayoutBuilder(
      builder: (context, constraints) {
        const reduceFactor = 0.9;
        Size size = Size.square((constraints.maxWidth < constraints.maxHeight)
            ? constraints.maxWidth * reduceFactor
            : constraints.maxHeight * reduceFactor);
        return buildBoard(size);
      },
    );
  }

  // Widget buildLayout(
  //   BuildContext context,
  //   BoxConstraints constraints,
  // ) {
  //   const reduceFactor = 0.9;
  //   Size size = Size.square((constraints.maxWidth < constraints.maxHeight)
  //       ? constraints.maxWidth * reduceFactor
  //       : constraints.maxHeight * reduceFactor);
  //   return buildBoard(size);
  // }

  Widget buildHoleAtIngex(
    Ingex holeIngex,
    Size size,
    BuildContext context,
  ) {
    return DragTarget<Ingex>(
      builder: (
        context,
        candidateData,
        rejectedData,
      ) {
        Color color = Theme.of(context).colorScheme.secondary;
        if (isPegBeingDragged) {
          if (holeIngex == ingexOfPegBeingDragged) {
            color = isPegDroppableOnTheHoleBelow ? Colors.pink : Colors.teal;
          }
        }
        return FoxHole(
          index: holeIngex,
          size: size,
          color: color,
        );
      },
      onWillAcceptWithDetails: (pegIngex) {
        bool isPegDroppableInHole =
            feeseConfiguration.checkIfPegIsDroppableInHole(
          // pegIndex ?? Ingex(0, 0),
          pegIngex.data,
          holeIngex,
        );

        if (isPegDroppableInHole) {
          setState(() {
            ingexOfPegBeingDragged = holeIngex;
            isPegBeingDragged = true;
            isPegDroppableOnTheHoleBelow = true;
          });
        } else {
          setState(() {
            ingexOfPegBeingDragged = holeIngex;
            isPegBeingDragged = true;
            isPegDroppableOnTheHoleBelow = false;
          });
        }

        return isPegDroppableInHole;
      },
      onLeave: (pegIngex) {
        setState(() {
          isPegBeingDragged = false;
        });
      },
      onAcceptWithDetails: (pegIngex) {
        // print('Peg inserted at $pegIngex.');
        int pegToRemoveRow = (pegIngex.data.row + holeIngex.row) ~/ 2;
        int pegToRemoveColumn = (pegIngex.data.column + holeIngex.column) ~/ 2;

        setState(() {
          feeseConfiguration.pegs[pegIngex.data.row][pegIngex.data.column] =
              false;
          feeseConfiguration.pegs[pegToRemoveRow][pegToRemoveColumn] = false;
          feeseConfiguration.pegs[holeIngex.row][holeIngex.column] = true;
          isPegBeingDragged = false;

          isGameOver = feeseConfiguration.checkGameOver();
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

  FoxHole buildHoleWithPegAtIngex(
    Ingex holeIngex,
    Size size,
  ) {
    double reduceFactor = 0.8;
    Size pegSize = Size(
      size.width * reduceFactor,
      size.height * reduceFactor,
    );

    return FoxHole(
      index: holeIngex,
      size: size,
      color: isGameOver
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.secondary,
      peg: FeesePeg(
        index: holeIngex,
        size: pegSize,
      ),
    );
  }

  Widget buildBoxAtIngex(
    Ingex ingex,
    Size size,
    BuildContext context,
  ) {
    bool isHole = feeseConfiguration.holes[ingex.row][ingex.column];
    bool hasPeg = feeseConfiguration.pegs[ingex.row][ingex.column];

    Widget nothing = SizedBox.fromSize(size: size);

    return isHole
        ? hasPeg
            ? buildHoleWithPegAtIngex(ingex, size)
            : buildHoleAtIngex(
                ingex,
                size,
                context,
              )
        : nothing;
  }

  void resetBoard() {
    setState(() {
      feeseConfiguration = feeseFactory.get(0);
      isGameOver = false;
    });
  }

  Widget buildBoard(Size size) {
    Size boxSize = Size(
      size.width / feeseConfiguration.numberOfColumns,
      size.height / feeseConfiguration.numberOfRows,
    );

    List<Row> rows = [
      const Row(),
      const Row(),
      const Row(),
      const Row(),
      const Row(),
      const Row(),
      const Row(),
    ];

    for (int rowIndex = 0;
        rowIndex < feeseConfiguration.numberOfRows;
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
          columnIndex < feeseConfiguration.numberOfColumns;
          columnIndex++) {
        widgets[columnIndex] = buildBoxAtIngex(
          Ingex(rowIndex, columnIndex),
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
}
