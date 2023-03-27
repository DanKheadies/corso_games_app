import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:corso_games_app/widgets/widgets.dart';

part 'colors_slide_event.dart';
part 'colors_slide_state.dart';

class ColorsSlideBloc extends HydratedBloc<ColorsSlideEvent, ColorsSlideState> {
  ColorsSlideBloc() : super(const ColorsSlideState()) {
    on<LoadColorsSlide>(_onLoadColorsSlide);
    on<ToggleColorsSlideReset>(_onToggleColorsSlideReset);
    on<ToggleColorsSlideTimer>(_onToggleColorsSlideTimer);
    on<UpdateColorsSlideDifficulty>(_onUpdateColorsSlideDifficulty);
  }

  void _onLoadColorsSlide(
    LoadColorsSlide event,
    Emitter<ColorsSlideState> emit,
  ) {
    if (state.status == ColorsSlideStatus.loaded) return;

    emit(
      const ColorsSlideState(
        resetColors: false,
        showTimer: false,
        difficulty: ColorsSlideDifficulty.threeByThree,
        status: ColorsSlideStatus.loaded,
        size: 3,
        timerSeconds: 0,
      ),
    );
  }

  void _onToggleColorsSlideReset(
    ToggleColorsSlideReset event,
    Emitter<ColorsSlideState> emit,
  ) {
    emit(
      ColorsSlideState(
        resetColors: !state.resetColors,
        showTimer: state.showTimer,
        difficulty: state.difficulty,
        status: state.status,
        size: state.size,
        timerSeconds: state.timerSeconds,
      ),
    );
  }

  void _onToggleColorsSlideTimer(
    ToggleColorsSlideTimer event,
    Emitter<ColorsSlideState> emit,
  ) {
    emit(
      ColorsSlideState(
        resetColors: state.resetColors,
        showTimer: !state.showTimer,
        difficulty: state.difficulty,
        status: state.status,
        size: state.size,
        timerSeconds: state.timerSeconds,
      ),
    );
  }

  void _onUpdateColorsSlideDifficulty(
    UpdateColorsSlideDifficulty event,
    Emitter<ColorsSlideState> emit,
  ) {
    var rando = Random().nextInt(13) + 2;
    if (event.size == 0) {
      Controller.gridSize = rando;
    } else {
      Controller.gridSize = event.size;
    }

    print('should reset colors?');
    emit(
      ColorsSlideState(
        resetColors: true,
        showTimer: state.showTimer,
        difficulty: event.difficulty,
        status: state.status,
        size: event.size == 0 ? rando : event.size,
        timerSeconds: 0,
      ),
    );
  }

  @override
  ColorsSlideState? fromJson(Map<String, dynamic> json) {
    return ColorsSlideState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ColorsSlideState state) {
    return state.toJson();
  }
}
