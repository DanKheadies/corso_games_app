part of 'snake_bloc.dart';

class SnakeEvent extends Equatable {
  const SnakeEvent();

  @override
  List<Object?> get props => [];
}

class LoadSnake extends SnakeEvent {}

class ResetSnake extends SnakeEvent {
  final SnakeStatus snakeStatus;

  const ResetSnake({
    required this.snakeStatus,
  });

  @override
  List<Object?> get props => [
        snakeStatus,
      ];
}

class UpdateSnakeBoard extends SnakeEvent {
  final int? food;
  final int? gameSpeed;
  final int? numberOfSquares;
  final List<int>? snakePosition;
  final SnakeDirection? snakeDirection;
  final SnakeSpeed? snakeSpeed;
  final SnakeStatus? snakeStatus;

  const UpdateSnakeBoard({
    this.food,
    this.gameSpeed,
    this.numberOfSquares,
    this.snakePosition,
    this.snakeDirection,
    this.snakeSpeed,
    this.snakeStatus,
  });

  @override
  List<Object?> get props => [
        food,
        gameSpeed,
        numberOfSquares,
        snakePosition,
        snakeDirection,
        snakeSpeed,
        snakeStatus,
      ];
}

class UpdateSnakeSpeed extends SnakeEvent {
  final SnakeSpeed snakeSpeed;

  const UpdateSnakeSpeed({
    required this.snakeSpeed,
  });

  @override
  List<Object?> get props => [
        snakeSpeed,
      ];
}
