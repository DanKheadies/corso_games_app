import 'package:corso_games_app/models/models.dart';
import 'package:flutter/material.dart';

class Peg extends StatelessWidget {
  final Index index;
  final Size size;

  const Peg({
    super.key,
    required this.index,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: SizedBox(
        width: size.width,
        height: size.height,
        child: Card(
          color: Theme.of(context).colorScheme.tertiary,
          elevation: 4,
          shape: const CircleBorder(),
        ),
      ),
      childWhenDragging: const SizedBox(),
      data: index,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          elevation: 1,
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}
