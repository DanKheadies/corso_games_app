import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'snake_event.dart';
part 'snake_state.dart';

class SnakeBloc extends Bloc<SnakeEvent, SnakeState> {
  SnakeBloc() : super(const SnakeState()) {
    on<LoadSnake>(_onLoadSnake);
    // on<SetSnakeBoard>(_onSetSnakeBoard);
    on<ResetSnake>(_onResetSnake);
    on<UpdateSnakeBoard>(_onUpdateSnakeBoard);
    on<UpdateSnakeSpeed>(_onUpdateSnakeSpeed);
  }

  void _onLoadSnake(
    LoadSnake event,
    Emitter<SnakeState> emit,
  ) {
    print('load snake');
    // emit(SnakeLoading());
    // Note: if we had a SnakeLoading event, we'd emit it to show spinner.
    // But the data is hydrated or instant, so no need.

    if (state.snakeStatus == SnakeStatus.loaded) return;
    print('loading..');

    emit(
      const SnakeState(
        food: 45, // 45
        gameSpeed: 300, // 300
        numberOfSquares: 620, // 620
        snakePosition: [45, 65, 85, 105, 125], // [45, 65, 85, 105, 125]
        snakeDirection: SnakeDirection.down,
        snakeSpeed: SnakeSpeed.average,
        snakeStatus: SnakeStatus.loaded,
      ),
    );
    // Note: we emit the full state, but if we want to avoid updating all fields,
    // then we'll just add(Event()) as show below
  }

  // void _onSetSnakeBoard(
  //   SetSnakeBoard event,
  //   Emitter<SnakeState> emit,
  // ) {}

  void _onResetSnake(
    ResetSnake event,
    Emitter<SnakeState> emit,
  ) {
    print('reset snake');
    // add(
    //   ResetSnake(
    //     snakeStatus: state.snakeStatus != SnakeStatus.reset
    //         ? SnakeStatus.reset
    //         : SnakeStatus.loaded,
    //   ),
    // );
    emit(
      SnakeState(
        snakeStatus: state.snakeStatus != SnakeStatus.reset
            ? SnakeStatus.reset
            : SnakeStatus.loaded,
      ),
    );
    // Note: using add() instead of emit() b/c we're only modifying a small
    // piece of state with this event rather than the whole state, like above
    // NOTE: don't think that's right, i.e. running add() in update caused an infinite loop
    // Need to update / emit the new state rather than add. I think you add in a
    // case where you have more than one state, e.g. ThingLoading, ThingLoaded, etc.
    // instead of what we have here, i.e. SnakeState.
    // TODO: see if the other variables need to be passed in on a State() emit
  }

  void _onUpdateSnakeBoard(
    UpdateSnakeBoard event,
    Emitter<SnakeState> emit,
  ) {
    print('update snake');
    print(event.snakePosition);
    print(event.food);
    // TODO: keeps running
    // RESOLVED: see NOTE above
    // TODO: not running when passing just the snakePosition List thru
    // Same issue I was experiencing in Solitare and had to pass in a "never the same" value
    // (SolitareTicker?)
    // Seems related to Dart checking it for changes, and seeing "nothing"
    // Change to requiring it to see if that makes the difference
    // Update: being a required field doesn't matter. Going to remove the removeAt()
    // UPDATE: idiot.. context.read<> FML

    // add(
    //   UpdateSnakeBoard(
    //     food: event.food ?? state.food,
    //     gameSpeed: event.gameSpeed ?? state.gameSpeed,
    //     numberOfSquares: event.numberOfSquares ?? state.numberOfSquares,
    //     snakePosition: event.snakePosition ?? state.snakePosition,
    //     snakeDirection: event.snakeDirection ?? state.snakeDirection,
    //     snakeSpeed: event.snakeSpeed ?? state.snakeSpeed,
    //     snakeStatus: event.snakeStatus ?? state.snakeStatus,
    //   ),
    // );
    emit(
      SnakeState(
        food: event.food ?? state.food,
        gameSpeed: event.gameSpeed ?? state.gameSpeed,
        numberOfSquares: event.numberOfSquares ?? state.numberOfSquares,
        snakePosition: event.snakePosition ?? state.snakePosition,
        // snakePosition: event.snakePosition,
        snakeDirection: event.snakeDirection ?? state.snakeDirection,
        snakeSpeed: event.snakeSpeed ?? state.snakeSpeed,
        snakeStatus: event.snakeStatus ?? state.snakeStatus,
      ),
    );
    // Note: if a piece of state was udpated via the event, update the state.
    // Otherwise, just keep using the state value that was present.
  }

  void _onUpdateSnakeSpeed(
    UpdateSnakeSpeed event,
    Emitter<SnakeState> emit,
  ) {
    print('update snake speed');
    emit(
      SnakeState(
        food: 45,
        gameSpeed: state.gameSpeed,
        numberOfSquares: state.numberOfSquares,
        snakePosition: const [45, 65, 85, 105, 125],
        snakeDirection: SnakeDirection.down,
        snakeSpeed: event.snakeSpeed,
        snakeStatus: SnakeStatus.reset,
      ),
    );
    // Note: updating the speed causes a hard reset, so we'll emit().
  }
}
