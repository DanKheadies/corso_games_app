import 'dart:math';

import 'package:corso_games_app/widgets/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'colors_slide_event.dart';
part 'colors_slide_state.dart';

class ColorsSlideBloc extends HydratedBloc<ColorsSlideEvent, ColorsSlideState> {
  ColorsSlideBloc() : super(const ColorsSlideState()) {
    on<LoadColorsSlide>(_onLoadColorsSlide);
    on<ToggleColorsSlideReset>(_onToggleColorsSlideReset);
    // on<ToggleColorsSlideTimer>(_onToggleColorsSlideTimer);
    on<UpdateColorsSlideDifficulty>(_onUpdateColorsSlideDifficulty);
    on<UpdateColorsSlidePieces>(_onUpdateColorsSlidePieces);
    on<UpdateColorsSlideScore>(_onUpdateColorsSlideScore);
  }

  void _onLoadColorsSlide(
    LoadColorsSlide event,
    Emitter<ColorsSlideState> emit,
  ) {
    // print('on load: ${state.colorsStatus}');
    if (state.colorsStatus == ColorsSlideStatus.loaded) return;

    emit(
      const ColorsSlideState(
        resetColors: false,
        // showColorsTimer: false,
        colorsDifficulty: ColorsSlideDifficulty.threeByThree,
        colorsStatus: ColorsSlideStatus.loaded,
        colorsScore: 0,
        colorsSize: 3,
        // colorsTimerSeconds: 0,
        colorsPieces: [],
        colorsIndexMap: {},
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
        // showColorsTimer: state.showColorsTimer,
        colorsDifficulty: state.colorsDifficulty,
        colorsStatus: state.colorsStatus,
        colorsScore: 0,
        colorsSize: state.colorsSize,
        // colorsTimerSeconds: state.colorsTimerSeconds,
        // colorsTimerSeconds: 0,
        colorsPieces: state.colorsPieces,
        colorsIndexMap: state.colorsIndexMap,
      ),
    );
  }

  // void _onToggleColorsSlideTimer(
  //   ToggleColorsSlideTimer event,
  //   Emitter<ColorsSlideState> emit,
  // ) {
  //   emit(
  //     ColorsSlideState(
  //       resetColors: state.resetColors,
  //       showColorsTimer: !state.showColorsTimer,
  //       colorsDifficulty: state.colorsDifficulty,
  //       colorsStatus: state.colorsStatus,
  //       colorsScore: state.colorsScore,
  //       colorsSize: state.colorsSize,
  //       colorsTimerSeconds: state.colorsTimerSeconds,
  //       colorsPieces: state.colorsPieces,
  //       colorsIndexMap: state.colorsIndexMap,
  //     ),
  //   );
  // }

  void _onUpdateColorsSlideDifficulty(
    UpdateColorsSlideDifficulty event,
    Emitter<ColorsSlideState> emit,
  ) {
    var rando = Random().nextInt(13) + 2;

    emit(
      ColorsSlideState(
        resetColors: true,
        // showColorsTimer: state.showColorsTimer,
        colorsDifficulty: event.colorsDifficulty,
        colorsStatus: state.colorsStatus,
        colorsScore: 0,
        colorsSize: event.colorsSize == 0 ? rando : event.colorsSize,
        // colorsTimerSeconds: 0,
        colorsPieces: state.colorsPieces,
        colorsIndexMap: state.colorsIndexMap,
      ),
    );
  }

  void _onUpdateColorsSlidePieces(
    UpdateColorsSlidePieces event,
    Emitter<ColorsSlideState> emit,
  ) {
    emit(
      ColorsSlideState(
        resetColors: state.resetColors,
        // showColorsTimer: state.showColorsTimer,
        colorsDifficulty: state.colorsDifficulty,
        colorsStatus: state.colorsStatus,
        colorsScore: state.colorsScore,
        colorsSize: state.colorsSize,
        // colorsTimerSeconds: state.colorsTimerSeconds,
        colorsPieces: event.colorsPieces,
        colorsIndexMap: event.colorsIndexMap,
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
        // showColorsTimer: state.showColorsTimer,
        colorsDifficulty: state.colorsDifficulty,
        colorsStatus: state.colorsStatus,
        colorsScore: event.colorsReset
            ? 0
            : state.colorsScore + event.colorsIncreaseAmount,
        colorsSize: state.colorsSize,
        // colorsTimerSeconds: 0,
        colorsPieces: state.colorsPieces,
        colorsIndexMap: state.colorsIndexMap,
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
