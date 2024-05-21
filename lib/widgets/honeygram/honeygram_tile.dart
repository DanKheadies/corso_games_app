import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HoneygramTile extends StatefulWidget {
  final String letter;
  final bool isCenter;
  final ValueChanged<String> onPressed;

  const HoneygramTile({
    super.key,
    required this.letter,
    required this.onPressed,
    required this.isCenter,
  });

  @override
  State<HoneygramTile> createState() => _HoneygramTileState();
}

class _HoneygramTileState extends State<HoneygramTile> {
  bool isDown = false;

  Color getColor(Color color) {
    return isDown ? color : color.withOpacity(0.9);
  }

  @override
  Widget build(BuildContext context) {
    Color color = widget.isCenter
        ? getColor(Theme.of(context).colorScheme.primary)
        : getColor(Theme.of(context).colorScheme.secondary);

    return GestureDetector(
      onTap: () {
        widget.onPressed(widget.letter);
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          isDown = true;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          isDown = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isDown = false;
        });
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            height: 75.0,
            width: 75.0,
            child: CustomPaint(
              painter: HexagonPainter(
                color: color,
              ),
            ),
          ),
          Text(
            widget.letter.toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
