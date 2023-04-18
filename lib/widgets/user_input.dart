import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/cubits/cubits.dart';

class UserInput extends StatelessWidget {
  const UserInput({
    Key? key,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
          ),
        );
      },
    );
  }
}
