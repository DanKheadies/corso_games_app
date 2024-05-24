import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'snake_event.dart';
part 'snake_state.dart';

class SnakeBloc extends HydratedBloc<SnakeEvent, SnakeState> {
  SnakeBloc() : super(const SnakeState()) {
    on<LoadSnake>(_onLoadSnake);
    on<ResetSnake>(_onResetSnake);
    on<UpdateSnakeBoard>(_onUpdateSnakeBoard);
    on<UpdateSnakeSpeed>(_onUpdateSnakeSpeed);
  }

  void _onLoadSnake(
    LoadSnake event,
    Emitter<SnakeState> emit,
  ) {
    if (state.snakeStatus == SnakeStatus.loaded) return;

    // Note: load values from "absolute zero" to what the loaded condition should be
    emit(
      SnakeState(
        colNum: 15,
        // food: 45,
        food: 33,
        gameSpeed: 300,
        numberOfSquares: state.numberOfSquares,
        // snakePosition: const [45, 65, 85, 105, 125],
        snakePosition: const [33, 48, 63, 78, 93],
        snakeDirection: SnakeDirection.down,
        snakeSpeed: SnakeSpeed.average,
        snakeStatus: SnakeStatus.loaded,
      ),
    );
  }

  void _onResetSnake(
    ResetSnake event,
    Emitter<SnakeState> emit,
  ) {
    emit(
      SnakeState(
        colNum: 15,
        // food: 45,
        food: 33,
        gameSpeed: state.gameSpeed,
        numberOfSquares: state.numberOfSquares,
        // snakePosition: const [45, 65, 85, 105, 125],
        snakePosition: const [33, 48, 63, 78, 93],
        snakeDirection: SnakeDirection.down,
        snakeSpeed: state.snakeSpeed,
        snakeStatus: state.snakeStatus != SnakeStatus.reset
            ? SnakeStatus.reset
            : SnakeStatus.loaded,
      ),
    );
    // TODO: see if the other variables need to be passed in on a State() emit
    // Resolved: yup, pass that shit thru / update as needed
  }

  void _onUpdateSnakeBoard(
    UpdateSnakeBoard event,
    Emitter<SnakeState> emit,
  ) {
    // if (event.gameSpeed != null) {
    //   print('speed updated to ${event.gameSpeed}');
    // }
    emit(
      SnakeState(
        colNum: event.colNum ?? state.colNum,
        food: event.food ?? state.food,
        gameSpeed: event.gameSpeed ?? state.gameSpeed,
        numberOfSquares: event.numberOfSquares ?? state.numberOfSquares,
        snakePosition: event.snakePosition ?? state.snakePosition,
        snakeDirection: event.snakeDirection ?? state.snakeDirection,
        snakeSpeed: event.snakeSpeed ?? state.snakeSpeed,
        snakeStatus: event.snakeStatus ?? state.snakeStatus,
      ),
    );
  }

  void _onUpdateSnakeSpeed(
    UpdateSnakeSpeed event,
    Emitter<SnakeState> emit,
  ) {
    emit(
      SnakeState(
        colNum: 15,
        // food: 45,
        food: 33,
        gameSpeed: state.gameSpeed,
        numberOfSquares: state.numberOfSquares,
        // snakePosition: const [45, 65, 85, 105, 125],
        snakePosition: const [33, 48, 63, 78, 93],
        snakeDirection: SnakeDirection.down,
        snakeSpeed: event.snakeSpeed,
        snakeStatus: SnakeStatus.reset,
      ),
    );
  }

  @override
  SnakeState? fromJson(Map<String, dynamic> json) {
    return SnakeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SnakeState state) {
    return state.toJson();
  }
}
