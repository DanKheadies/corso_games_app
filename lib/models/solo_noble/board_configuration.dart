import 'package:corso_games_app/models/models.dart';

class BoardConfiguration {
  final List<List<bool>> holes;
  final List<List<bool>> pegs;

  final int numberOfRows;
  final int numberOfColumns;

  BoardConfiguration(
    this.holes,
    this.pegs,
    this.numberOfRows,
    this.numberOfColumns,
  );

  bool checkIfPegIsDroppableInHole(
    Index peg,
    Index hole,
  ) {
    if (!pegs[peg.row][peg.column]) {
      return false;
    }
    if (!holes[hole.row][hole.column]) {
      return false;
    }

    int rowCheck = (peg.row - hole.row).abs();
    int colCheck = (peg.column - hole.column).abs();

    if (((rowCheck == 2) & (colCheck == 0)) |
        ((rowCheck == 0) & (colCheck == 2))) {
      int rowMiddle = (peg.row + hole.row) ~/ 2;
      int columnMiddle = (peg.column + hole.column) ~/ 2;
      bool middlePegExists = pegs[rowMiddle][columnMiddle];
      return middlePegExists;
    }
    return false;
  }

  bool checkGameOver() {
    for (int rowIndex = 0; rowIndex < numberOfRows; rowIndex++) {
      for (int columnIndex = 0; columnIndex < numberOfColumns; columnIndex++) {
        bool holeExists = holes[rowIndex][columnIndex];
        bool holeIsEmpty = !pegs[rowIndex][columnIndex];

        if (holeExists && holeIsEmpty) {
          if (rowIndex + 2 < numberOfRows) {
            if (checkIfPegIsDroppableInHole(
                Index(
                  rowIndex + 2,
                  columnIndex,
                ),
                Index(
                  rowIndex,
                  columnIndex,
                ))) {
              return false;
            }
          }

          if (rowIndex - 2 >= 0) {
            if (checkIfPegIsDroppableInHole(
                Index(
                  rowIndex - 2,
                  columnIndex,
                ),
                Index(
                  rowIndex,
                  columnIndex,
                ))) {
              return false;
            }
          }

          if (columnIndex + 2 < numberOfColumns) {
            if (checkIfPegIsDroppableInHole(
                Index(
                  rowIndex,
                  columnIndex + 2,
                ),
                Index(
                  rowIndex,
                  columnIndex,
                ))) {
              return false;
            }
          }

          if (columnIndex - 2 >= 0) {
            if (checkIfPegIsDroppableInHole(
                Index(
                  rowIndex,
                  columnIndex - 2,
                ),
                Index(
                  rowIndex,
                  columnIndex,
                ))) {
              return false;
            }
          }
        }
      }
    }
    return true;
  }
}
