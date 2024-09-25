import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BreakupBrickZone extends PositionComponent {
  BreakupBrickZone({
    required super.position,
    required super.size,
    required this.numBricksX,
    required this.numBricksY,
    required this.spacingX,
    required this.spacingY,
    required this.color,
  }) {
    brickSize = Vector2(
      (size.x - (numBricksX - 1) * spacingX) / numBricksX,
      (size.y - (numBricksY - 1) * spacingY) / numBricksY,
    );
  }

  final int numBricksX;
  final int numBricksY;
  final double spacingX;
  final double spacingY;
  late final Vector2 brickSize;
  final Color color;

  @override
  void onMount() {
    super.onMount();

    for (var row = 0; row < numBricksY; row++) {
      for (var col = 0; col < numBricksX; col++) {
        final brickPosition = position +
            Vector2(
              brickSize.x * 0.5 + col * (brickSize.x + spacingX),
              brickSize.y * 0.5 + row * (brickSize.y + spacingY),
            );
        final brick = BreakupBrick(
          color: color,
          position: brickPosition,
          size: brickSize,
        );
        parent?.add(brick);
      }
    }
  }
}
