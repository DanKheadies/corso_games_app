part of 'minesweeper_bloc.dart';

enum MinesweeperDifficulty {
  tbd,
  easy,
  medium,
  hard,
  harder,
  wtf,
}

enum MinesweeperStatus {
  loading,
  loaded,
  gameOver,
  error,
}

class MinesweeperState extends Equatable {
  final bool resetMinesweeper;
  final bool showMineTimer;
  final MinesweeperDifficulty mineDifficulty;
  final MinesweeperStatus mineStatus;
  final int mineTimerSeconds;
  final int bombProbability;
  final int maxProbability;
  final int bombCount;
  final int squaresLeft;
  final List<List<MineBoardSquare>> mineBoard;
  final List<bool> openedSquares;
  final List<bool> flaggedSquares;

  const MinesweeperState({
    this.resetMinesweeper = false,
    this.showMineTimer = false,
    this.mineDifficulty = MinesweeperDifficulty.easy,
    this.mineStatus = MinesweeperStatus.loading,
    this.mineTimerSeconds = 0,
    this.bombProbability = 3,
    this.maxProbability = 30,
    this.bombCount = 0,
    this.squaresLeft = 0,
    this.mineBoard = const [],
    this.openedSquares = const [],
    this.flaggedSquares = const [],
  });

  factory MinesweeperState.fromJson(Map<String, dynamic> json) {
    var mineList = json['mineBoard'] as List;
    // TODO: pass in row & column counts
    List<List<MineBoardSquare>> mineBoardList = List.generate(15, (i) {
      return List.generate(10, (j) {
        return MineBoardSquare();
      });
    });

    for (int i = 0; i < mineList.length; i++) {
      for (int j = 0; j < mineList[i].length; j++) {
        mineBoardList[i][j].hasBomb = mineList[i][j]['hasBomb'];
        mineBoardList[i][j].bombsAround = mineList[i][j]['bombsAround'];
      }
    }

    var openedList = json['openedSquares'] as List<bool>;
    List<bool> openedSquaresList = openedList;

    var flaggedList = json['flaggedSquares'] as List<bool>;
    List<bool> flaggedSquaresList = flaggedList;

    return MinesweeperState(
      resetMinesweeper: json['resetMinesweeper'],
      showMineTimer: json['showMineTimer'],
      mineDifficulty: MinesweeperDifficulty.values.firstWhere(
        (diff) => diff.name.toString() == json['mineDifficulty'],
      ),
      mineStatus: MinesweeperStatus.values.firstWhere(
        (status) => status.name.toString() == json['mineStatus'],
      ),
      mineTimerSeconds: json['mineTimerSeconds'],
      bombProbability: json['bombProbability'],
      maxProbability: json['maxProbability'],
      bombCount: json['bombCount'],
      squaresLeft: json['squaresLeft'],
      mineBoard: mineBoardList,
      openedSquares: openedSquaresList,
      flaggedSquares: flaggedSquaresList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resetMinesweeper': resetMinesweeper,
      'showMineTimer': showMineTimer,
      'mineDifficulty': mineDifficulty.name,
      'mineStatus': mineStatus.name,
      'mineTimerSeconds': mineTimerSeconds,
      'bombProbability': bombProbability,
      'maxProbability': maxProbability,
      'bombCount': bombCount,
      'squaresLeft': squaresLeft,
      'mineBoard': mineBoard,
      'openedSquares': openedSquares,
      'flaggedSquares': flaggedSquares,
    };
  }

  @override
  List<Object> get props => [
        resetMinesweeper,
        showMineTimer,
        mineDifficulty,
        mineStatus,
        mineTimerSeconds,
        bombProbability,
        maxProbability,
        bombCount,
        squaresLeft,
        mineBoard,
        openedSquares,
        flaggedSquares,
      ];
}
