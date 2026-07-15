import 'package:corso_games_app/models/models.dart';

class FeeseFactory {
  final List<FeeseConfiguration> FeeseConfigurations = [
    FeeseConfiguration(
      [
        [false, false, true, true, true, false, false],
        [false, false, true, true, true, false, false],
        [true, true, true, true, true, true, true],
        [true, true, true, true, true, true, true],
        [true, true, true, true, true, true, true],
        [false, false, true, true, true, false, false],
        [false, false, true, true, true, false, false],
      ],
      [
        [false, false, true, true, true, false, false],
        [false, false, true, true, true, false, false],
        [true, true, true, true, true, true, true],
        [true, true, true, false, true, true, true],
        [true, true, true, true, true, true, true],
        [false, false, true, true, true, false, false],
        [false, false, true, true, true, false, false],
      ],
      7,
      7,
    ),
  ];

  FeeseConfiguration get(int version) {
    FeeseConfiguration config = FeeseConfigurations[version];

    // int length = config.numberOfRows * config.numberOfColumns;
    List<List<bool>> holes = [
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false]
    ];
    List<List<bool>> pegs = [
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false],
      [false, false, false, false, false, false, false]
    ];
    for (int row = 0; row < config.numberOfRows; row++) {
      List<bool> holeRow = [false, false, false, false, false, false, false];
      List<bool> pegRow = [false, false, false, false, false, false, false];
      for (int column = 0; column < config.numberOfColumns; column++) {
        holeRow[column] = config.holes[row][column];
        pegRow[column] = config.pegs[row][column];
      }
      holes[row] = holeRow;
      pegs[row] = pegRow;
    }

    return FeeseConfiguration(
      holes,
      pegs,
      config.numberOfRows,
      config.numberOfColumns,
    );
  }
}
