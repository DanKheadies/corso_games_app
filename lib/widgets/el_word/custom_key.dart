import 'package:flutter/material.dart';

import 'package:corso_games_app/models/el_word/letter.dart';

class CustomKey extends StatelessWidget {
  final String text;
  final Set<Letter?> evaluation;
  final Function()? onTap;

  const CustomKey({
    Key? key,
    required this.text,
    required this.evaluation,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<Letter?> letterEvaluation =
        evaluation.where((letter) => letter!.letter == text).toList();

    Color color = (letterEvaluation.isNotEmpty)
        ? letterEvaluation
                .any((letter) => letter!.evaluation == Evaluation.correct)
            ? Theme.of(context).colorScheme.tertiary
            : letterEvaluation
                    .any((letter) => letter!.evaluation == Evaluation.present)
                ? Theme.of(context).colorScheme.secondary
                : letterEvaluation.any(
                        (letter) => letter!.evaluation == Evaluation.missing)
                    ? Theme.of(context).colorScheme.surface.withOpacity(0.825)
                    : Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.primary;

    return Container(
      width: width * .075,
      height: height * .05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.background,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      margin: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: height * .0175,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
