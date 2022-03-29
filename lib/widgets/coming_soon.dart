import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 35,
          color: Theme.of(context).colorScheme.primary,
          shadows: [
            Shadow(
              blurRadius: 7.0,
              color: Theme.of(context).colorScheme.tertiary,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText('Coming'),
            FlickerAnimatedText('Soon'),
          ],
        ),
      ),
    );
  }
}
