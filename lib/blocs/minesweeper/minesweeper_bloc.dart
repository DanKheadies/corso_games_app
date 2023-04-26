import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:corso_games_app/models/models.dart';

part 'minesweeper_event.dart';
part 'minesweeper_state.dart';

class MinesweeperBloc extends HydratedBloc<MinesweeperEvent, MinesweeperState> {
  MinesweeperBloc() : super(const MinesweeperState()) {
    on<LoadMinesweeper>(_onLoadMinesweeper);
    on<SetMinesweeperBoard>(_onSetMinesweeperBoard);
    on<ToggleMinesweeperReset>(_onToggleMinesweeperReset);
    on<ToggleMinesweeperTimer>(_onToggleMinesweeperTimer);
    on<UpdateMinesweeperBoard>(_onUpdateMinesweeperBoard);
    on<UpdateMinesweeperDifficulty>(_onUpdateMinesweeperDifficulty);
    on<UpdateMinesweeperTimer>(_onUpdateMinesweeperTimer);
  }

  void _onLoadMinesweeper(
    LoadMinesweeper event,
    Emitter<MinesweeperState> emit,
  ) {
    // print('on load: ${state.mineStatus}');
    if (state.mineStatus == MinesweeperStatus.loaded) return;
    // print('load');
    emit(
      const MinesweeperState(
        resetMinesweeper: false,
        showMineTimer: false,
        mineDifficulty: MinesweeperDifficulty.easy,
        mineStatus: MinesweeperStatus.loaded,
        mineTimerSeconds: 0,
        mineTimerPauseSeconds: 0,
        mineTimerStatus: MinesweeperTimerStatus.stopped,
        bombProbability: 3,
        maxProbability: 30,
        bombCount: 0,
        squaresLeft: 0,
        mineBoard: [],
        openedSquares: [],
        flaggedSquares: [],
      ),
    );
  }

  void _onSetMinesweeperBoard(
    SetMinesweeperBoard event,
    Emitter<MinesweeperState> emit,
  ) {
    emit(
      MinesweeperState(
        resetMinesweeper: false,
        showMineTimer: state.showMineTimer,
        mineDifficulty: state.mineDifficulty,
        mineStatus: state.mineStatus,
        mineTimerSeconds: 0,
        mineTimerPauseSeconds: 0,
        mineTimerStatus: state.mineTimerStatus,
        bombProbability: event.bombProbability,
        maxProbability: event.maxProbability,
        bombCount: event.bombCount,
        squaresLeft: event.squaresLeft,
        mineBoard: event.mineBoard,
        openedSquares: event.openedSquares,
        flaggedSquares: event.flaggedSquares,
      ),
    );
  }

  void _onToggleMinesweeperReset(
    ToggleMinesweeperReset event,
    Emitter<MinesweeperState> emit,
  ) {
    emit(
      MinesweeperState(
        resetMinesweeper: !state.resetMinesweeper,
        showMineTimer: state.showMineTimer,
        mineDifficulty: state.mineDifficulty,
        mineStatus: state.mineStatus,
        mineTimerSeconds: 0,
        mineTimerPauseSeconds: 0,
        mineTimerStatus: state.showMineTimer
            ? MinesweeperTimerStatus.reset
            : MinesweeperTimerStatus.stopped, // TODO
        bombProbability: state.bombProbability,
        maxProbability: state.maxProbability,
        bombCount: state.bombCount,
        squaresLeft: state.squaresLeft,
        mineBoard: state.mineBoard,
        openedSquares: state.openedSquares,
        flaggedSquares: state.flaggedSquares,
      ),
    );
  }

  void _onToggleMinesweeperTimer(
    ToggleMinesweeperTimer event,
    Emitter<MinesweeperState> emit,
  ) {
    // print('ms bloc toggle timer; currently ${state.mineTimerStatus}');
    emit(
      MinesweeperState(
        resetMinesweeper: state.resetMinesweeper,
        showMineTimer: !state.showMineTimer,
        mineDifficulty: state.mineDifficulty,
        mineStatus: state.mineStatus,
        mineTimerSeconds: state.mineTimerSeconds,
        mineTimerPauseSeconds: state.mineTimerPauseSeconds,
        mineTimerStatus: state.mineTimerStatus == MinesweeperTimerStatus.stopped
            ? MinesweeperTimerStatus.resume
            : MinesweeperTimerStatus.stopped,
        // mineTimerStatus: state.mineTimerStatus, // TODO?
        bombProbability: state.bombProbability,
        maxProbability: state.maxProbability,
        bombCount: state.bombCount,
        squaresLeft: state.squaresLeft,
        mineBoard: state.mineBoard,
        openedSquares: state.openedSquares,
        flaggedSquares: state.flaggedSquares,
      ),
    );
    // print('post ms bloc emit');
    // print(state.mineTimerStatus);
  }

  void _onUpdateMinesweeperBoard(
    UpdateMinesweeperBoard event,
    Emitter<MinesweeperState> emit,
  ) {
    emit(
      MinesweeperState(
        resetMinesweeper: state.resetMinesweeper,
        showMineTimer: state.showMineTimer,
        mineDifficulty: state.mineDifficulty,
        mineStatus: state.mineStatus,
        mineTimerSeconds: state.mineTimerSeconds,
        mineTimerPauseSeconds: state.mineTimerPauseSeconds,
        mineTimerStatus: state.mineTimerStatus,
        bombProbability: state.bombProbability,
        maxProbability: state.maxProbability,
        bombCount: state.bombCount,
        squaresLeft: event.squaresLeft,
        mineBoard: event.mineBoard,
        openedSquares: event.openedSquares,
        flaggedSquares: event.flaggedSquares,
      ),
    );
  }

  void _onUpdateMinesweeperDifficulty(
    UpdateMinesweeperDifficulty event,
    Emitter<MinesweeperState> emit,
  ) {
    int bProb = 0;
    int mProb = 0;

    if (event.mineDifficulty == MinesweeperDifficulty.easy) {
      bProb = 3;
      mProb = 30;
    } else if (event.mineDifficulty == MinesweeperDifficulty.medium) {
      bProb = 3;
      mProb = 20;
    } else if (event.mineDifficulty == MinesweeperDifficulty.hard) {
      bProb = 3;
      mProb = 15;
    } else if (event.mineDifficulty == MinesweeperDifficulty.harder) {
      bProb = 5;
      mProb = 20;
    } else if (event.mineDifficulty == MinesweeperDifficulty.wtf) {
      bProb = 5;
      mProb = 15;
    }

    emit(
      MinesweeperState(
        resetMinesweeper: true,
        showMineTimer: state.showMineTimer,
        mineDifficulty: event.mineDifficulty,
        mineStatus: state.mineStatus,
        mineTimerSeconds: 0,
        mineTimerPauseSeconds: 0,
        mineTimerStatus: MinesweeperTimerStatus.reset,
        bombProbability: bProb,
        maxProbability: mProb,
        bombCount: state.bombCount,
        squaresLeft: state.squaresLeft,
        mineBoard: state.mineBoard,
        openedSquares: state.openedSquares,
        flaggedSquares: state.flaggedSquares,
      ),
    );
  }

  void _onUpdateMinesweeperTimer(
    UpdateMinesweeperTimer event,
    Emitter<MinesweeperState> emit,
  ) {
    emit(
      MinesweeperState(
        resetMinesweeper: false,
        showMineTimer: state.showMineTimer,
        mineDifficulty: state.mineDifficulty,
        mineStatus: state.mineStatus,
        mineTimerSeconds: event.mineTimerSeconds,
        mineTimerPauseSeconds: event.mineTimerPauseSeconds,
        mineTimerStatus: event.mineTimerStatus,
        bombProbability: state.bombProbability,
        maxProbability: state.maxProbability,
        bombCount: state.bombCount,
        squaresLeft: state.squaresLeft,
        mineBoard: state.mineBoard,
        openedSquares: state.openedSquares,
        flaggedSquares: state.flaggedSquares,
      ),
    );
  }

  @override
  MinesweeperState? fromJson(Map<String, dynamic> json) {
    return MinesweeperState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(MinesweeperState state) {
    // print('ms toJson');
    return state.toJson();
  }
}
