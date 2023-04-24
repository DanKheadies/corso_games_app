part of 'timer_cubit.dart';

enum TimerGame {
  colorsSlide,
  dinoDash,
  elWord,
  minesweeper,
  solitare,
  soloNoble,
  none,
}

enum TimerStatus {
  stopped,
  running,
  reset,
  error,
}

class TimerState extends Equatable {
  final int? colorsSlideActive;
  final int? colorsSlideCache;
  final int? dinoDashDuration;
  final int? elWordDuration;
  final int? minesweeperDuration;
  final int? solitareDuration;
  final int? soloNobleDuration;
  final TimerGame currentGame;
  final TimerStatus timerStatus;

  const TimerState({
    this.colorsSlideActive,
    this.colorsSlideCache,
    this.dinoDashDuration,
    this.elWordDuration,
    this.minesweeperDuration,
    this.solitareDuration,
    this.soloNobleDuration,
    required this.currentGame,
    required this.timerStatus,
  });

  factory TimerState.initial() {
    return const TimerState(
      colorsSlideActive: 0,
      colorsSlideCache: 0,
      dinoDashDuration: 0,
      elWordDuration: 0,
      minesweeperDuration: 0,
      solitareDuration: 0,
      soloNobleDuration: 0,
      currentGame: TimerGame.none,
      timerStatus: TimerStatus.stopped,
    );
  }

  TimerState copyWith({
    int? colorsSlideActive,
    int? colorsSlideCache,
    int? dinoDashDuration,
    int? elWordDuration,
    int? minesweeperDuration,
    int? solitareDuration,
    int? soloNobleDuration,
    TimerGame? currentGame,
    TimerStatus? timerStatus,
  }) {
    return TimerState(
      colorsSlideActive: colorsSlideActive ?? this.colorsSlideActive,
      colorsSlideCache: colorsSlideCache ?? this.colorsSlideCache,
      dinoDashDuration: dinoDashDuration ?? this.dinoDashDuration,
      elWordDuration: elWordDuration ?? this.elWordDuration,
      minesweeperDuration: minesweeperDuration ?? this.minesweeperDuration,
      solitareDuration: solitareDuration ?? this.solitareDuration,
      soloNobleDuration: soloNobleDuration ?? this.soloNobleDuration,
      currentGame: currentGame ?? this.currentGame,
      timerStatus: timerStatus ?? this.timerStatus,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        colorsSlideActive,
        colorsSlideCache,
        dinoDashDuration,
        elWordDuration,
        minesweeperDuration,
        solitareDuration,
        soloNobleDuration,
        currentGame,
        timerStatus,
      ];
}
