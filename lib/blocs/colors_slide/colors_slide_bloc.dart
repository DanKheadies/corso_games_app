import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:corso_games_app/widgets/widgets.dart';

part 'colors_slide_event.dart';
part 'colors_slide_state.dart';

class ColorsSlideBloc extends HydratedBloc<ColorsSlideEvent, ColorsSlideState> {
  ColorsSlideBloc() : super(const ColorsSlideState()) {
    on<LoadColorsSlide>(_onLoadColorsSlide);
    on<ToggleColorsSlideReset>(_onToggleColorsSlideReset);
    on<ToggleColorsSlideTimer>(_onToggleColorsSlideTimer);
    on<UpdateColorsSlideDifficulty>(_onUpdateColorsSlideDifficulty);
    on<UpdateColorsSlidePieces>(_onUpdateColorsSlidePieces);
    on<UpdateColorsSlideScore>(_onUpdateColorsSlideScore);
  }

  void _onLoadColorsSlide(
    LoadColorsSlide event,
    Emitter<ColorsSlideState> emit,
  ) {
    // print('on load: ${state.status}');
    if (state.status == ColorsSlideStatus.loaded) return;

    emit(
      const ColorsSlideState(
        resetColors: false,
        showTimer: false,
        difficulty: ColorsSlideDifficulty.threeByThree,
        status: ColorsSlideStatus.loaded,
        score: 0,
        size: 3,
        timerSeconds: 0,
        pieces: [],
        indexes: {},
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
        score: state.score,
        size: state.size,
        timerSeconds: state.timerSeconds,
        pieces: state.pieces,
        indexes: state.indexes,
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
        score: state.score,
        size: state.size,
        timerSeconds: state.timerSeconds,
        pieces: state.pieces,
        indexes: state.indexes,
      ),
    );
  }

  void _onUpdateColorsSlideDifficulty(
    UpdateColorsSlideDifficulty event,
    Emitter<ColorsSlideState> emit,
  ) {
    var rando = Random().nextInt(13) + 2;

    emit(
      ColorsSlideState(
        resetColors: true,
        showTimer: state.showTimer,
        difficulty: event.difficulty,
        status: state.status,
        score: 0,
        size: event.size == 0 ? rando : event.size,
        timerSeconds: 0, // TODO: sync to the actual timer
        pieces: state.pieces,
        indexes: state.indexes,
      ),
    );
  }

  void _onUpdateColorsSlidePieces(
    UpdateColorsSlidePieces event,
    Emitter<ColorsSlideState> emit,
  ) {
    // print('update pieces: ${state.status}');
    emit(
      ColorsSlideState(
        resetColors: state.resetColors,
        showTimer: state.showTimer,
        difficulty: state.difficulty,
        status: state.status,
        score: state.score,
        size: state.size,
        timerSeconds: state.timerSeconds,
        pieces: event.pieces,
        indexes: event.index,
      ),
    );
  }

  void _onUpdateColorsSlideScore(
    UpdateColorsSlideScore event,
    Emitter<ColorsSlideState> emit,
  ) {
    emit(
      ColorsSlideState(
        resetColors: state.resetColors,
        showTimer: state.showTimer,
        difficulty: state.difficulty,
        status: state.status,
        score: event.reset ? 0 : state.score + event.increaseAmount,
        size: state.size,
        timerSeconds: 0,
        pieces: state.pieces,
        indexes: state.indexes,
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
