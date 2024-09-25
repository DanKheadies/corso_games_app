import 'dart:async';

import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class BreakupWorld extends Forge2DWorld
    with HasGameReference<BreakupGame>, DragCallbacks {
  BreakupWorld({
    required this.context,
  }) : super(gravity: Vector2.zero());

  late BreakupPaddle paddle;
  BuildContext context;

  @override
  FutureOr<void> onLoad() async {
    await _start(context);

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    paddle.hAxis = 0;
    super.onDragStart(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    paddle.hAxis = 0;
    super.onDragEnd(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    paddle.hAxis = 0;

    if (event.localDelta.x < 0 &&
        paddle.position.x > event.localEndPosition.x) {
      paddle.hAxis -= 1;
    }
    if (event.localDelta.x > 0 &&
        paddle.position.x < event.localEndPosition.x) {
      paddle.hAxis += 1;
    }

    super.onDragUpdate(event);
  }

  void reset() {
    removeAll(children);
    Future.delayed(
      const Duration(seconds: 1),
      () => _start(context),
    );
  }

  Future<void> _start(BuildContext context) async {
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Theme.of(context).colorScheme.secondary;
    Color surface = Theme.of(context).colorScheme.surface;
    Color tertiary = Theme.of(context).colorScheme.tertiary;

    await add(
      BreakupWalls(
        surface,
        game.camera.viewport.virtualSize,
        5 * BreakupGame.lengthFactor,
      ),
    );

    await add(
      BreakupBall(
        color: secondary,
        radius: 4 * BreakupGame.lengthFactor,
        position: Vector2(
          0,
          game.camera.viewport.virtualSize.y * 0.5 - 4,
        ),
      ),
    );

    await add(
      paddle = BreakupPaddle(
        color: primary,
        size: Vector2(30, 6)..scale(BreakupGame.lengthFactor),
        position: Vector2(
          0,
          game.camera.viewport.virtualSize.y * 0.5 - 3,
        ),
      ),
    );

    await add(
      BreakupBrickZone(
        position: Vector2(
          -game.camera.viewport.virtualSize.x * 0.375,
          -game.camera.viewport.virtualSize.y * 0.45,
        ),
        size: Vector2(
          game.camera.viewport.virtualSize.x * 0.75,
          game.camera.viewport.virtualSize.y * 0.333,
        ),
        numBricksX: 6,
        numBricksY: 9,
        spacingX: 1.875,
        spacingY: 1.25,
        color: tertiary,
      ),
    );
  }
}
