import 'package:flutter/material.dart';

class XSign extends StatelessWidget {
  final double shapeSize;

  const XSign({
    Key? key,
    required this.shapeSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.close,
      size: shapeSize,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}

class Circle extends StatelessWidget {
  final double shapeSize;

  const Circle({
    Key? key,
    required this.shapeSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle_outlined,
      size: shapeSize,
      color: Theme.of(context).colorScheme.tertiary,
    );
  }
}
