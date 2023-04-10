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

enum MinesweeperTimerStatus {
  paused,
  reset,
  resume,
  running,
  stopped,
}

class MinesweeperState extends Equatable {
  final bool resetMinesweeper;
  final bool showMineTimer;
  final MinesweeperDifficulty mineDifficulty;
  final MinesweeperStatus mineStatus;
  final int mineTimerSeconds;
  final int mineTimerPauseSeconds;
  final MinesweeperTimerStatus mineTimerStatus;
  final int bombProbability;
  final int maxProbability;
  final int bombCount;
  final int squaresLeft;
  final int? mineColumnCount;
  final int? mineRowCount;
  final List<List<MineBoardSquare>> mineBoard;
  final List<bool> openedSquares;
  final List<bool> flaggedSquares;

  const MinesweeperState({
    this.resetMinesweeper = false,
    this.showMineTimer = false,
    this.mineDifficulty = MinesweeperDifficulty.easy,
    this.mineStatus = MinesweeperStatus.loading,
    this.mineTimerStatus = MinesweeperTimerStatus.stopped,
    this.mineTimerSeconds = 0,
    this.mineTimerPauseSeconds = 0,
    this.bombProbability = 3,
    this.maxProbability = 30,
    this.bombCount = 0,
    this.squaresLeft = 0,
    this.mineColumnCount = 10,
    this.mineRowCount = 15,
    this.mineBoard = const [],
    this.openedSquares = const [],
    this.flaggedSquares = const [],
  });

  factory MinesweeperState.fromJson(Map<String, dynamic> json) {
    var mineCC = json['mineColumnCount'] ?? 10;
    var mineRC = json['mineRowCount'] ?? 15;
    var mineList = json['mineBoard'] as List;
    // TODO: pass in row & column counts
    List<List<MineBoardSquare>> mineBoardList = List.generate(mineRC, (i) {
      return List.generate(mineCC, (j) {
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
      mineTimerPauseSeconds: json['mineTimerPauseSeconds'],
      mineTimerStatus: MinesweeperTimerStatus.values.firstWhere(
        (timer) => timer.name.toString() == json['mineTimerStatus'],
      ),
      bombProbability: json['bombProbability'],
      maxProbability: json['maxProbability'],
      bombCount: json['bombCount'],
      squaresLeft: json['squaresLeft'],
      mineBoard: mineBoardList,
      mineColumnCount: mineCC,
      mineRowCount: mineRC,
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
      'mineTimerPauseSeconds': mineTimerPauseSeconds,
      'mineTimerStatus': mineTimerStatus.name,
      'bombProbability': bombProbability,
      'maxProbability': maxProbability,
      'bombCount': bombCount,
      'squaresLeft': squaresLeft,
      'mineBoard': mineBoard,
      'mineColumnCount': mineColumnCount,
      'mineRowCount': mineRowCount,
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
        mineTimerPauseSeconds,
        mineTimerStatus,
        bombProbability,
        maxProbability,
        bombCount,
        squaresLeft,
        mineBoard,
        openedSquares,
        flaggedSquares,
      ];
}
