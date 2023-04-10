import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/widgets.dart';

class PaddedSpinnerButton extends StatelessWidget {
  final bool shouldSpin;
  final Color color;
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;

  const PaddedSpinnerButton({
    Key? key,
    required this.shouldSpin,
    required this.color,
    required this.text,
    required this.onPressed,
    required this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shouldSpin
        ? SizedBox(
            height: 80,
            width: 80,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          )
        : PaddedButton(
            color: color,
            text: text,
            onPressed: onPressed,
            isDisabled: isDisabled,
          );
  }
}
