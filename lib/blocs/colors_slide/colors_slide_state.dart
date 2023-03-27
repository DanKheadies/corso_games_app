part of 'colors_slide_bloc.dart';

enum ColorsSlideDifficulty {
  tbd,
  threeByThree,
  fourByFour,
  fiveByFive,
  sevenBySeven,
  tenByTen,
  yolo,
}

enum ColorsSlideStatus {
  loading,
  loaded,
  gameOver,
  error,
}

class ColorsSlideState extends Equatable {
  final bool resetColors;
  final bool showTimer;
  final ColorsSlideDifficulty difficulty;
  final ColorsSlideStatus status;
  final int size;
  final int timerSeconds;

  const ColorsSlideState({
    this.resetColors = false,
    this.showTimer = false,
    this.difficulty = ColorsSlideDifficulty.threeByThree,
    this.status = ColorsSlideStatus.loading,
    this.size = 3,
    this.timerSeconds = 0,
  });

  factory ColorsSlideState.fromJson(Map<String, dynamic> json) {
    return ColorsSlideState(
      resetColors: json['resetColors'],
      showTimer: json['showtimer'],
      difficulty: ColorsSlideDifficulty.values.firstWhere(
        (diff) => diff.name.toString() == json['difficulty'],
      ),
      status: ColorsSlideStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
      size: json['size'],
      timerSeconds: json['timerSeconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resetColors': resetColors,
      'showTimer': showTimer,
      'difficulty': difficulty.name,
      'status': status.name,
      'size': size,
      'timerSeconds': timerSeconds,
    };
  }

  @override
  List<Object> get props => [
        resetColors,
        showTimer,
        difficulty,
        status,
        size,
        timerSeconds,
      ];
}
