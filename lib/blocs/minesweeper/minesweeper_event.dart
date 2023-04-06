part of 'minesweeper_bloc.dart';

class MinesweeperEvent extends Equatable {
  const MinesweeperEvent();

  @override
  List<Object> get props => [];
}

class LoadMinesweeper extends MinesweeperEvent {}

class SetMinesweeperBoard extends MinesweeperEvent {
  final int bombProbability;
  final int maxProbability;
  final int bombCount;
  final int squaresLeft;
  final List<List<MineBoardSquare>> mineBoard;
  final List<bool> openedSquares;
  final List<bool> flaggedSquares;

  const SetMinesweeperBoard({
    required this.bombProbability,
    required this.maxProbability,
    required this.bombCount,
    required this.squaresLeft,
    required this.mineBoard,
    required this.openedSquares,
    required this.flaggedSquares,
  });

  @override
  List<Object> get props => [
        bombProbability,
        maxProbability,
        bombCount,
        squaresLeft,
        mineBoard,
        openedSquares,
        flaggedSquares,
      ];
}

class ToggleMinesweeperReset extends MinesweeperEvent {}

class ToggleMinesweeperTimer extends MinesweeperEvent {}

class UpdateMinesweeperDifficulty extends MinesweeperEvent {
  final bool resetMinesweeper;
  final MinesweeperDifficulty mineDifficulty;

  const UpdateMinesweeperDifficulty({
    required this.resetMinesweeper,
    required this.mineDifficulty,
  });

  @override
  List<Object> get props => [
        resetMinesweeper,
        mineDifficulty,
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
