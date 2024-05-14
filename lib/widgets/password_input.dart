// import 'package:corso_games_app/cubits/cubits.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PasswordInput extends StatelessWidget {
//   final TextEditingController? controller;
//   final bool isSignUp;

//   const PasswordInput({
//     Key? key,
//     this.controller,
//     required this.isSignUp,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<Authentication, SignUpState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             TextField(
//               controller: controller,
//               onChanged: (password) {
//                 isSignUp
//                     ? context.read<SignUpCubit>().passwordChanged(password)
//                     : context.read<LoginCubit>().passwordChanged(password);
//               },
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: TextStyle(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//               ),
//               obscureText: true,
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.surface,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
