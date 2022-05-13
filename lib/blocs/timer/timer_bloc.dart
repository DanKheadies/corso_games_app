import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:corso_games_app/models/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  // static const _duration = 60;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerReady(0)) {
    on<TimerStarted>(_onStartTimer);
    on<TimerTicked>(_onTickTimer);
    on<TimerPaused>(_onPauseTimer);
    on<TimerResumed>(_onResumeTimer);
    on<TimerReset>(_onResetTimer);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStartTimer(TimerStarted event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerRunning(event.duration));
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _onTickTimer(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      TimerRunning(event.duration),
      // event.duration > 0
      //     ? TimerRunning(event.duration)
      //     : const TimerComplete(0),
    );
  }

  void _onPauseTimer(TimerPaused event, Emitter<TimerState> emit) {
    _tickerSubscription?.pause();
    emit(
      TimerStopped(state.duration),
    );
  }

  void _onResumeTimer(TimerResumed event, Emitter<TimerState> emit) {
    _tickerSubscription?.resume();
    emit(
      TimerRunning(state.duration),
    );
  }

  void _onResetTimer(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(
      const TimerReady(0),
    );
  }
}
