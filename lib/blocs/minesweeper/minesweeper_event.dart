part of 'minesweeper_bloc.dart';

class MinesweeperEvent extends Equatable {
  const MinesweeperEvent();

  @override
  List<Object> get props => [];
}

class LoadMinesweeper extends MinesweeperEvent {}

class ToggleMinesweeperReset extends MinesweeperEvent {}

class ToggleMinesweeperTimer extends MinesweeperEvent {}

class UpdateMinesweeperDifficulty extends MinesweeperEvent {
  final bool resetMinesweeper;
  final MinesweeperDifficulty mineDifficulty;
  // final int bombProbability;
  // final int maxProbability;
  // final int bombCount;
  // final int squaresLeft;
  // final List<List<MineBoardSquare>> mineBoard;
  // final List<bool> openedSquares;
  // final List<bool> flaggedSquares;

  const UpdateMinesweeperDifficulty({
    required this.resetMinesweeper,
    required this.mineDifficulty,
    // required this.bombProbability,
    // required this.maxProbability,
  });

  @override
  List<Object> get props => [
        resetMinesweeper,
        mineDifficulty,
        // bombProbability,
        // maxProbability,
      ];
}

class UpdateMinesweeperBoard extends MinesweeperEvent {
  final int squaresLeft;
  final List<List<MineBoardSquare>> mineBoard;
  final List<bool> openedSquares;
  final List<bool> flaggedSquares;

  const UpdateMinesweeperBoard({
    required this.squaresLeft,
    required this.mineBoard,
    required this.openedSquares,
    required this.flaggedSquares,
  });

  @override
  List<Object> get props => [
        squaresLeft,
        mineBoard,
        openedSquares,
        flaggedSquares,
      ];
}

// class UpdateColorsSlideScore extends ColorsSlideEvent {
//   final bool reset;
//   final int increaseAmount;

//   const UpdateColorsSlideScore({
//     required this.reset,
//     required this.increaseAmount,
//   });

//   @override
//   List<Object> get props => [
//         reset,
//         increaseAmount,
//       ];
// }
