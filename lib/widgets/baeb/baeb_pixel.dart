import 'package:flutter/material.dart';

class BaebPixel extends StatelessWidget {
  final Color color;
  final String? child;

  const BaebPixel({super.key, required this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      margin: const EdgeInsets.all(1),
      child: Center(
        child: Text(child ?? '', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
