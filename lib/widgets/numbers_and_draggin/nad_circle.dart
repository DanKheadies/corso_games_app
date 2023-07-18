import 'package:flutter/material.dart';

class NadCircle extends StatelessWidget {
  final bool isOpaque;
  final bool isExtraOpqaue;
  final double size;
  final Color color;
  final String text;

  const NadCircle({
    super.key,
    this.isExtraOpqaue = false,
    required this.isOpaque,
    required this.size,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            // Stationary border
            color: isOpaque
                ? Theme.of(context).colorScheme.surface.withOpacity(0.333)
                : Theme.of(context).colorScheme.surface,
          ),
          borderRadius: BorderRadius.circular(50),
          color: isOpaque
              ? color.withOpacity(isExtraOpqaue ? 0.666 : 0.333)
              : color,
        ),
        child: Center(
          child: text == '' || text == '0'
              ? const SizedBox()
              : DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Text(text),
                ),
        ),
      ),
    );
  }
}
