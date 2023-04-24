// import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// import 'package:corso_games_app/widgets/widgets.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerState.initial());

  void cacheTime(
    TimerGame currentGame,
    // int timeToCache,
  ) {
    print('cache');
    emit(
      state.copyWith(
        colorsSlideCache: currentGame == TimerGame.colorsSlide
            // ? timeToCache
            ? state.colorsSlideActive
            : state.colorsSlideCache,
        // timerStatus: TimerStatus.running,
      ),
    );
  }

  void updateTime(
    TimerGame currentGame,
    int newTime,
  ) {
    print('update time: $newTime');
    emit(
      state.copyWith(
        colorsSlideActive: currentGame == TimerGame.colorsSlide
            ? newTime
            : state.colorsSlideActive,
      ),
    );
  }

  // void increaseTimer(TimerGame currentGame) {
  //   print('daco');
  //   emit(
  //     state.copyWith(
  //       colorsSlideDuration: currentGame == TimerGame.colorsSlide
  //           ? state.colorsSlideDuration! + 1
  //           : state.colorsSlideDuration,
  //       dinoDashDuration: currentGame == TimerGame.dinoDash
  //           ? state.dinoDashDuration! + 1
  //           : state.dinoDashDuration,
  //       elWordDuration: currentGame == TimerGame.elWord
  //           ? state.elWordDuration! + 1
  //           : state.elWordDuration,
  //       minesweeperDuration: currentGame == TimerGame.minesweeper
  //           ? state.minesweeperDuration! + 1
  //           : state.minesweeperDuration,
  //       solitareDuration: currentGame == TimerGame.solitare
  //           ? state.solitareDuration! + 1
  //           : state.solitareDuration,
  //       soloNobleDuration: currentGame == TimerGame.soloNoble
  //           ? state.soloNobleDuration! + 1
  //           : state.soloNobleDuration,
  //       timerStatus: TimerStatus.running,
  //     ),
  //   );
  // }

  // void pauseTimer(TimerGame currentGame) {
  //   emit(
  //     state.copyWith(
  //       timerStatus: TimerStatus.stopped,
  //     ),
  //   );
  // }

  void resetTimer(TimerGame currentGame) {
    emit(
      state.copyWith(
        colorsSlideActive:
            currentGame == TimerGame.colorsSlide ? 0 : state.colorsSlideActive,
        colorsSlideCache:
            currentGame == TimerGame.colorsSlide ? 0 : state.colorsSlideCache,
        dinoDashDuration:
            currentGame == TimerGame.dinoDash ? 0 : state.dinoDashDuration,
        elWordDuration:
            currentGame == TimerGame.elWord ? 0 : state.elWordDuration,
        minesweeperDuration: currentGame == TimerGame.minesweeper
            ? 0
            : state.minesweeperDuration,
        solitareDuration:
            currentGame == TimerGame.solitare ? 0 : state.solitareDuration,
        soloNobleDuration:
            currentGame == TimerGame.soloNoble ? 0 : state.soloNobleDuration,
        timerStatus: TimerStatus.running,
      ),
    );
  }
}
