import 'dart:async';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MSTimer extends StatefulWidget {
  const MSTimer({
    Key? key,
    // required this.showTimer,
    // required this.timerStatus,
    required this.mineTimerSeconds,
    required this.mineTimerPauseSeconds,
    required this.mineTimerStatus,
  }) : super(key: key);

  // final bool showTimer;
  // final String timerStatus;
  final int mineTimerSeconds;
  final int mineTimerPauseSeconds;
  final MinesweeperTimerStatus mineTimerStatus;

  @override
  State<MSTimer> createState() => _MSTimerState();
}

class _MSTimerState extends State<MSTimer> {
  // int seconds = 0;
  // int pausedSeconds = 0;
  late Stream<int> timerStream;
  late StreamSubscription<int> timerSubscription;

  @override
  void initState() {
    super.initState();
    print('init ms timer');
    // print(widget.showTimer);
    // print(widget.mineTimerStatus);
    // TODO: I think remove / ignore all this and use the resume function below?
    // Might need to initialize the stopWatchStream & subscription but do nothing?
    // if (widget.showTimer &&
    //     widget.mineTimerStatus == MinesweeperTimerStatus.running) {
    //   timerStream = stopWatchStream();
    //   timerSubscription = timerStream.listen((int newTick) {
    //     // setState(() {
    //     //   seconds = newTick;
    //     // });
    //     print(newTick);
    //     print(widget.mineTimerStatus);
    //     context.read<MinesweeperBloc>().add(
    //           UpdateMinesweeperTimer(
    //             mineTimerSeconds: newTick,
    //             mineTimerPauseSeconds: widget.mineTimerPauseSeconds,
    //             mineTimerStatus: widget.mineTimerStatus,
    //           ),
    //         );
    //   });
    // }
    timerStream = stopWatchStream();
    timerSubscription = timerStream.listen((int newTick) {
      // setState(() {
      //   seconds = newTick;
      // });
      print(newTick);
      // print(widget.mineTimerStatus);
      context.read<MinesweeperBloc>().add(
            UpdateMinesweeperTimer(
              mineTimerSeconds: newTick,
              mineTimerPauseSeconds: widget.mineTimerPauseSeconds,
              mineTimerStatus: MinesweeperTimerStatus.running,
            ),
          );
    });

    // stopTimer();
  }

  Stream<int> stopWatchStream() {
    late StreamController<int> streamController;
    Timer intTimer = Timer(const Duration(seconds: 0), () {});
    Timer timer = Timer(const Duration(seconds: 0), () {});
    Duration timerInterval = const Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != intTimer) {
        timer.cancel();
        timer = intTimer;
        counter = 0;
        streamController.close();
      }
      print('stop timer in stopWatch');
      // context.read<MinesweeperBloc>().add(
      //       UpdateMinesweeperTimer(
      //         mineTimerSeconds: widget.mineTimerSeconds,
      //         mineTimerPauseSeconds: widget.mineTimerPauseSeconds,
      //         mineTimerStatus: MinesweeperTimerStatus.stop,
      //       ),
      //     );
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
      print('tick timer in stopWatch');
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
      print('start timer in stopWAtch');
      // context.read<MinesweeperBloc>().add(
      //       UpdateMinesweeperTimer(
      //         mineTimerSeconds: widget.mineTimerSeconds,
      //         mineTimerPauseSeconds: widget.mineTimerPauseSeconds,
      //         mineTimerStatus: MinesweeperTimerStatus.resume,
      //       ),
      //     );
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  void pauseTimer() {
    timerSubscription.pause();
    print('pause timer');
    // context.read<MinesweeperBloc>().add(
    //       UpdateMinesweeperTimer(
    //         mineTimerSeconds: widget.mineTimerSeconds,
    //         mineTimerPauseSeconds: widget.mineTimerPauseSeconds,
    //         mineTimerStatus: MinesweeperTimerStatus.paused,
    //       ),
    //     );
  }

  void resetTimer() {
    stopTimer();

    // setState(() {
    //   seconds = 0;
    //   pausedSeconds = 0;
    // });
    print('reset timer');
    // context.read<MinesweeperBloc>().add(
    //       const UpdateMinesweeperTimer(
    //         mineTimerSeconds: 0,
    //         mineTimerPauseSeconds: 0,
    //         mineTimerStatus: MinesweeperTimerStatus.running,
    //       ),
    //     );
    timerSubscription = timerStream.listen((int newTick) {
      // setState(() {
      //   seconds = newTick;
      // });
      print('reset timer in sub');
      // context.read<MinesweeperBloc>().add(
      //       UpdateMinesweeperTimer(
      //         mineTimerSeconds: newTick,
      //         mineTimerPauseSeconds: widget.mineTimerPauseSeconds,
      //         mineTimerStatus: widget.mineTimerStatus,
      //       ),
      //     );
    });
  }

  void resumeTimer() {
    stopTimer();
    // setState(() {
    //   pausedSeconds = seconds;
    // });
    print('resume timer');
    // context.read<MinesweeperBloc>().add(
    //       UpdateMinesweeperTimer(
    //         mineTimerSeconds: widget.mineTimerSeconds,
    //         mineTimerPauseSeconds: widget.mineTimerSeconds,
    //         mineTimerStatus: MinesweeperTimerStatus.running,
    //       ),
    //     );
    timerSubscription = timerStream.listen((int newTick) {
      // setState(() {
      //   seconds = newTick + pausedSeconds;
      // });
      print('resume timer in sub');
      // context.read<MinesweeperBloc>().add(
      //       UpdateMinesweeperTimer(
      //         mineTimerSeconds: widget.mineTimerSeconds,
      //         mineTimerPauseSeconds: widget.mineTimerPauseSeconds + newTick,
      //         mineTimerStatus: MinesweeperTimerStatus.running,
      // //         mineTimerStatus: widget.mineTimerStatus,
      //       ),
      //     );
    });
  }

  void stopTimer() {
    timerSubscription.cancel();
    timerStream = stopWatchStream();
    print('stop timer');
    context.read<MinesweeperBloc>().add(
          UpdateMinesweeperTimer(
            mineTimerSeconds: widget.mineTimerSeconds,
            mineTimerPauseSeconds: widget.mineTimerPauseSeconds,
            mineTimerStatus: MinesweeperTimerStatus.stopped,
          ),
        );
    // Timer(
    //   const Duration(milliseconds: 100),
    //   () {
    //     context.read<MinesweeperBloc>().add(
    //           UpdateMinesweeperTimer(
    //             mineTimerSeconds: widget.mineTimerSeconds,
    //             mineTimerPauseSeconds: widget.mineTimerPauseSeconds,
    //             mineTimerStatus: MinesweeperTimerStatus.stopped,
    //           ),
    //         );
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.mineTimerSeconds != 0) {
    //   if (widget.mineTimerStatus == MinesweeperTimerStatus.pause) pauseTimer();
    //   if (widget.mineTimerStatus == MinesweeperTimerStatus.reset) resetTimer();
    //   if (widget.mineTimerStatus == MinesweeperTimerStatus.resume) {
    //     resumeTimer();
    //   }
    //   if (widget.mineTimerStatus == MinesweeperTimerStatus.stop) stopTimer();
    // }

    return BlocBuilder<MinesweeperBloc, MinesweeperState>(
      builder: (context, state) {
        if (state.mineStatus != MinesweeperStatus.error) {
          if (state.mineTimerStatus == MinesweeperTimerStatus.reset) {
            print('ms timer is going to reset');
            resetTimer();
          }
          // TODO: the others?

          //   if (widget.mineTimerStatus == MinesweeperTimerStatus.pause) pauseTimer();
          //   if (widget.mineTimerStatus == MinesweeperTimerStatus.reset) resetTimer();
          //   if (widget.mineTimerStatus == MinesweeperTimerStatus.resume) {
          //     resumeTimer();
          //   }
          //   if (widget.mineTimerStatus == MinesweeperTimerStatus.stop) stopTimer();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Text(
                  'timer:',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              Text(
                '${state.mineTimerSeconds}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Text(
                  'error',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
