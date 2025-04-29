import 'package:flutter/material.dart';

class StacksDialog extends StatelessWidget {
  final Widget content;

  const StacksDialog({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    const double outerPadding = 40;
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(
          left: outerPadding,
          right: outerPadding,
          top: outerPadding,
          bottom: outerPadding / 2,
        ),
        child: content,
      ),
    );
  }
}
