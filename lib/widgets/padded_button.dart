import 'package:flutter/material.dart';

class PaddedButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;

  const PaddedButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onPressed,
    required this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Material(
        elevation: !isDisabled ? 5.0 : 0.0,
        color: !isDisabled ? color : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: !isDisabled ? onPressed : () {},
          minWidth: 200.0,
          height: 48.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: !isDisabled
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}
