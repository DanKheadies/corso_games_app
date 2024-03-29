// import 'dart:async';

// import 'package:flutter/material.dart';

// class CSTimer extends StatefulWidget {
//   const CSTimer({
//     Key? key,
//     required this.timer,
//     required this.timerStatus,
//   }) : super(key: key);

//   final bool timer;
//   final String timerStatus;

//   @override
//   State<CSTimer> createState() => _CSTimerState();
// }

// class _CSTimerState extends State<CSTimer> {
//   int seconds = 0;
//   int pausedSeconds = 0;
//   late Stream<int> timerStream;
//   late StreamSubscription<int> timerSubscription;

//   Stream<int> stopWatchStream() {
//     late StreamController<int> streamController;
//     Timer intTimer = Timer(const Duration(seconds: 0), () {});
//     Timer timer = Timer(const Duration(seconds: 0), () {});
//     Duration timerInterval = const Duration(seconds: 1);
//     int counter = 0;

//     void stopTimer() {
//       if (timer != intTimer) {
//         timer.cancel();
//         timer = intTimer;
//         counter = 0;
//         streamController.close();
//       }
//     }

//     void tick(_) {
//       counter++;
//       streamController.add(counter);
//     }

//     void startTimer() {
//       timer = Timer.periodic(timerInterval, tick);
//     }

//     streamController = StreamController<int>(
//       onListen: startTimer,
//       onCancel: stopTimer,
//       onResume: startTimer,
//       onPause: stopTimer,
//     );

//     return streamController.stream;
//   }

//   @override
//   void initState() {
//     super.initState();
//     print('init');
//     if (widget.timer) {
//       print('timer true');
//       timerStream = stopWatchStream();
//       timerSubscription = timerStream.listen((int newTick) {
//         setState(() {
//           seconds = newTick;
//         });
//       });
//     }
//   }

//   void pauseTimer() {
//     timerSubscription.pause();
//   }

//   void resetTimer() {
//     stopTimer();

//     setState(() {
//       seconds = 0;
//       pausedSeconds = 0;
//     });
//     timerSubscription = timerStream.listen((int newTick) {
//       setState(() {
//         seconds = newTick;
//       });
//     });
//   }

//   void resumeTimer() {
//     stopTimer();
//     setState(() {
//       pausedSeconds = seconds;
//     });
//     timerSubscription = timerStream.listen((int newTick) {
//       setState(() {
//         seconds = newTick + pausedSeconds;
//       });
//     });
//   }

//   void stopTimer() {
//     timerSubscription.cancel();
//     timerStream = stopWatchStream();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     stopTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (seconds != 0 && widget.timerStatus == 'pause') pauseTimer();
//     if (seconds != 0 && widget.timerStatus == 'reset') resetTimer();
//     if (seconds != 0 && widget.timerStatus == 'resume') resumeTimer();
//     if (seconds != 0 && widget.timerStatus == 'stop') stopTimer();

//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(
//             top: 24,
//             bottom: 12,
//           ),
//           child: Text('timer:'),
//         ),
//         Text('$seconds'),
//       ],
//     );
//   }
// }
