import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

part 'minesweeper_event.dart';
part 'minesweeper_state.dart';

class MinesweeperBloc extends Bloc<MinesweeperEvent, MinesweeperState> {
  MinesweeperBloc() : super(const MinesweeperState()) {
    on<LoadMinesweeper>(_onLoadMinesweeper);
    on<ToggleMinesweeperReset>(_onToggleMinesweeperReset);
    on<ToggleMinesweeperTimer>(_onToggleMinesweeperTimer);
    on<UpdateMinesweeperBoard>(_onUpdateMinesweeperBoard);
    on<UpdateMinesweeperDifficulty>(_onUpdateMinesweeperDifficulty);
  }

  void _onLoadMinesweeper(
    LoadMinesweeper event,
    Emitter<MinesweeperState> emit,
  ) {
    // print('on load: ${state.status}');
    if (state.mineStatus == MinesweeperStatus.loaded) return;

    emit(
      const MinesweeperState(
        resetMinesweeper: false,
        showMineTimer: false,
        mineDifficulty: MinesweeperDifficulty.easy,
        mineStatus: MinesweeperStatus.loaded,
        mineTimerSeconds: 0,
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
        mineTimerSeconds: state.mineTimerSeconds,
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
    emit(
      MinesweeperState(
        resetMinesweeper: state.resetMinesweeper,
        showMineTimer: !state.showMineTimer,
        mineDifficulty: state.mineDifficulty,
        mineStatus: state.mineStatus,
        mineTimerSeconds: state.mineTimerSeconds,
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

  void _onUpdateMinesweeperBoard(
    UpdateMinesweeperBoard event,
    Emitter<MinesweeperState> emit,
  ) {
    // TODO?

    emit(
      MinesweeperState(
        resetMinesweeper: true,
        showMineTimer: state.showMineTimer,
        mineDifficulty: state.mineDifficulty,
        mineStatus: state.mineStatus,
        mineTimerSeconds: 0, // TODO: sync to the actual timer
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
        mineTimerSeconds: 0, // TODO: sync to the actual timer
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
}
