import 'package:flutter/material.dart';

@immutable
class StacksBrick {
  final int colorIndex;

  const StacksBrick({
    required this.colorIndex,
  });

  @override
  String toString() {
    return colorIndex.toString();
  }
}
