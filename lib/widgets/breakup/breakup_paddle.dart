// ignore_for_file: implementation_imports

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';

class BreakupPaddle extends BodyComponent with KeyboardHandler, TapCallbacks {
  BreakupPaddle({
    required this.size,
    required Color color,
    Vector2? position,
    // bool? isDragging,
  }) : super(
          paint: PaletteEntry(color).paint(),
          bodyDef: BodyDef(
            type: BodyType.kinematic,
            position: position,
            allowSleep: false,
          ),
          fixtureDefs: [
            FixtureDef(
              PolygonShape()
                ..setAsBoxXY(
                  size.x * 0.420,
                  size.y * 0.505,
                ),
              restitution: 1,
              friction: 0.25,
            ),
            FixtureDef(
              CircleShape()
                ..radius = size.y * 0.5
                ..position.setValues(
                  -size.x * 0.5 + size.y * 0.5,
                  0,
                ),
              restitution: 1,
              friction: 0.25,
            ),
            FixtureDef(
              CircleShape()
                ..radius = size.y * 0.5
                ..position.setValues(
                  size.x * 0.5 - size.y * 0.5,
                  0,
                ),
              restitution: 1,
              friction: 0.25,
            ),
            // isDragging != null
            //     ? FixtureDef(
            //         PolygonShape()
            //           ..setAsBoxXY(
            //             size.x,
            //             size.y,
            //           ),
            //       )
            //     : FixtureDef(
            //         CircleShape(),
            //       ),
          ],
        );

  final Vector2 size;

  double hAxis = 0;
  final double _maxSpeed = 20;

  bool get _isAtLimits =>
      (position.x < size.x * -2.25 && hAxis < 0) ||
      (position.x > size.x * 2.25 && hAxis > 0);

  @override
  void update(double dt) {
    body.linearVelocity.setValues(
      _isAtLimits ? 0.0 : hAxis * _maxSpeed,
      0,
    );
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    hAxis = 0;

    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      hAxis -= 1;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      hAxis += 1;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
