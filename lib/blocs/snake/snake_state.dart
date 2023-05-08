part of 'snake_bloc.dart';

enum SnakeDirection {
  up,
  down,
  left,
  right,
  none,
}

enum SnakeSpeed {
  slow,
  average,
  fast,
  faster,
  hell,
  progression,
}

enum SnakeStatus {
  loading, // transitional
  loaded,
  pause,
  unpause, // transitional
  play,
  reset, // transitional
  gameOver, // transitional (?)
  error,
}

class SnakeState extends Equatable {
  final int food;
  final int gameSpeed;
  final int numberOfSquares;
  final List<int> snakePosition;
  final SnakeDirection snakeDirection;
  final SnakeSpeed snakeSpeed;
  final SnakeStatus snakeStatus;

  // Note: "absolute zero" for values; can update once loaded
  const SnakeState({
    this.food = 0,
    this.gameSpeed = 0,
    this.numberOfSquares = 0,
    this.snakePosition = const [],
    this.snakeDirection = SnakeDirection.none,
    this.snakeSpeed = SnakeSpeed.average,
    this.snakeStatus = SnakeStatus.loading,
  });

  factory SnakeState.fromJson(Map<String, dynamic> json) {
    print('fromJson');

    // var snakeList = json['snakePosition'] as List<int>;
    // List<int> snakePositionList = snakeList;

    return SnakeState(
      food: json['food'],
      gameSpeed: json['gameSpeed'],
      numberOfSquares: json['numberOfSquares'],
      snakePosition: json['snakePosition'] as List<int>,
      snakeDirection: SnakeDirection.values.firstWhere(
        (dir) => dir.name.toString() == json['snakeDirection'],
      ),
      snakeSpeed: SnakeSpeed.values.firstWhere(
        (speed) => speed.name.toString() == json['snakeSpeed'],
      ),
      snakeStatus: SnakeStatus.values.firstWhere(
        (stat) => stat.name.toString() == json['snakeStatus'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    // print('toJson');

    return {
      'food': food,
      'gameSpeed': gameSpeed,
      'numberOfSquares': numberOfSquares,
      'snakePosition': snakePosition,
      'snakeDirection': snakeDirection.name,
      'snakeSpeed': snakeSpeed.name,
      'snakeStatus': snakeStatus.name,
    };
  }

  @override
  List<Object> get props => [
        food,
        gameSpeed,
        numberOfSquares,
        snakePosition,
        snakeDirection,
        snakeSpeed,
        snakeStatus,
      ];
}
