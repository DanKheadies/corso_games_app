// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:corso_games_app/blocs/el_word/el_word_bloc.dart';
// import 'package:corso_games_app/models/el_word/word.dart';

// class buildEndingScreen extends StatelessWidget {
//   const buildEndingScreen({
//     Key? key,
//     required this.height,
//   }) : super(key: key);

//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Congrats, you won!',
//               style: TextStyle(
//                 // fontSize: 32,
//                 fontSize: height * .04,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).colorScheme.tertiary,
//               ),
//             ),
//             SizedBox(height: height * 0.05),
//             Text(
//               'The word was ',
//               style: TextStyle(
//                 fontSize: height * .04,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).colorScheme.tertiary,
//               ),
//             ),
//             SizedBox(height: height * 0.025),
//             Text(
//               state.solution,
//               style: TextStyle(
//                 // fontSize: 42,
//                 fontSize: height * .055,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//             ),
//             // const SizedBox(height: 50),
//             SizedBox(height: height * 0.05),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(15)),
//               child: Text(
//                 'Play Again',
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.secondary,
//                   // fontSize: 18,
//                   fontSize: height * 0.025,
//                 ),
//               ),
//               onPressed: () {
//                 Word.resetGuesses();
//                 context.read<ElWordBloc>().add(
//                       LoadGame(),
//                     );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
