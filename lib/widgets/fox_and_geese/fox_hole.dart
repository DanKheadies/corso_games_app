import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FoxHole extends StatefulWidget {
  final Ingex index;
  final Size size;
  final Color? color;
  final FeesePeg? peg;

  const FoxHole({
    super.key,
    required this.index,
    required this.size,
    this.color,
    this.peg,
  });

  @override
  State<FoxHole> createState() => _FoxHoleState();
}

class _FoxHoleState extends State<FoxHole> {
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
