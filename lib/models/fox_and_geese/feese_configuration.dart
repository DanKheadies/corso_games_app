import 'package:corso_games_app/models/models.dart';

class FeeseConfiguration {
  final List<List<bool>> holes;
  final List<List<bool>> pegs;

  final int numberOfRows;
  final int numberOfColumns;

  FeeseConfiguration(
    this.holes,
    this.pegs,
    this.numberOfRows,
    this.numberOfColumns,
  );

  bool checkIfPegIsDroppableInHole(
    Ingex peg,
    Ingex hole,
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

  // TODO
  bool checkGameOver() {
    for (int rowIngex = 0; rowIngex < numberOfRows; rowIngex++) {
      for (int columnIngex = 0; columnIngex < numberOfColumns; columnIngex++) {
        bool holeExists = holes[rowIngex][columnIngex];
        bool holeIsEmpty = !pegs[rowIngex][columnIngex];

        if (holeExists && holeIsEmpty) {
          if (rowIngex + 2 < numberOfRows) {
            if (checkIfPegIsDroppableInHole(
                Ingex(
                  rowIngex + 2,
                  columnIngex,
                ),
                Ingex(
                  rowIngex,
                  columnIngex,
                ))) {
              return false;
            }
          }

          if (rowIngex - 2 >= 0) {
            if (checkIfPegIsDroppableInHole(
                Ingex(
                  rowIngex - 2,
                  columnIngex,
                ),
                Ingex(
                  rowIngex,
                  columnIngex,
                ))) {
              return false;
            }
          }

          if (columnIngex + 2 < numberOfColumns) {
            if (checkIfPegIsDroppableInHole(
                Ingex(
                  rowIngex,
                  columnIngex + 2,
                ),
                Ingex(
                  rowIngex,
                  columnIngex,
                ))) {
              return false;
            }
          }

          if (columnIngex - 2 >= 0) {
            if (checkIfPegIsDroppableInHole(
                Ingex(
                  rowIngex,
                  columnIngex - 2,
                ),
                Ingex(
                  rowIngex,
                  columnIngex,
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
