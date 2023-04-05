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
  final ColorsSlideDifficulty difficulty;
  final int size;

  const UpdateColorsSlideDifficulty({
    required this.resetColors,
    required this.difficulty,
    required this.size,
  });

  @override
  List<Object> get props => [
        resetColors,
        difficulty,
        size,
      ];
}

class UpdateColorsSlidePieces extends ColorsSlideEvent {
  final List<GamePiece> pieces;
  final Map<Point, GamePiece> indexMap;

  const UpdateColorsSlidePieces({
    required this.pieces,
    required this.indexMap,
  });

  @override
  List<Object> get props => [
        pieces,
        indexMap,
      ];
}

class UpdateColorsSlideScore extends ColorsSlideEvent {
  final bool reset;
  final int increaseAmount;

  const UpdateColorsSlideScore({
    required this.reset,
    required this.increaseAmount,
  });

  @override
  List<Object> get props => [
        reset,
        increaseAmount,
      ];
}
