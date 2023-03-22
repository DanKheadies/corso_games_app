import 'package:flutter/material.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class Hole extends StatefulWidget {
  final Index index;
  final Size size;
  final Color? color;
  final Peg? peg;

  const Hole({
    super.key,
    required this.index,
    required this.size,
    this.color,
    this.peg,
  });

  @override
  State<Hole> createState() => _HoleState();
}

class _HoleState extends State<Hole> {
  double paddingFactor = 0.05;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: Padding(
        padding: EdgeInsets.all(widget.size.width * paddingFactor),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: widget.color ?? Colors.red,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: widget.peg,
          ),
        ),
      ),
    );
  }
}
