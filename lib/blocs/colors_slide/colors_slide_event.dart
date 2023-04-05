part of 'colors_slide_bloc.dart';

class ColorsSlideEvent extends Equatable {
  const ColorsSlideEvent();

  @override
  List<Object> get props => [];
}

class LoadColorsSlide extends ColorsSlideEvent {}

class ToggleColorsSlideReset extends ColorsSlideEvent {}

class ToggleColorsSlideTimer extends ColorsSlideEvent {}

class UpdateColorsSlideDifficulty extends ColorsSlideEvent {
  final bool resetColors;
  final ColorsSlideDifficulty colorsDifficulty;
  final int colorsSize;

  const UpdateColorsSlideDifficulty({
    required this.resetColors,
    required this.colorsDifficulty,
    required this.colorsSize,
  });

  @override
  List<Object> get props => [
        resetColors,
        colorsDifficulty,
        colorsSize,
      ];
}

class UpdateColorsSlidePieces extends ColorsSlideEvent {
  final List<ColorsGamePiece> colorsPieces;
  final Map<Point, ColorsGamePiece> colorsIndexMap;

  const UpdateColorsSlidePieces({
    required this.colorsPieces,
    required this.colorsIndexMap,
  });

  @override
  List<Object> get props => [
        colorsPieces,
        colorsIndexMap,
      ];
}

class UpdateColorsSlideScore extends ColorsSlideEvent {
  final bool colorsReset;
  final int colorsIncreaseAmount;

  const UpdateColorsSlideScore({
    required this.colorsReset,
    required this.colorsIncreaseAmount,
  });

  @override
  List<Object> get props => [
        colorsReset,
        colorsIncreaseAmount,
      ];
}
