part of 'timer_bloc.dart';

@immutable
abstract class TimerState extends Equatable {
  final int duration;
  const TimerState({required this.duration});

  @override
  List<Object> get props => [duration];
}

class TimerReady extends TimerState {
  const TimerReady(int duration) : super(duration: duration);
}

class TimerRunning extends TimerState {
  const TimerRunning(int duration) : super(duration: duration);
}

class TimerStopped extends TimerState {
  const TimerStopped(int duration) : super(duration: duration);
}

// class TimerComplete extends TimerState {
//   const TimerComplete(int duration) : super(duration: 0);
// }
