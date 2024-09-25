import 'dart:math';

import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BreakupBall extends BodyComponent
    with ContactCallbacks, ParentIsA<BreakupWorld> {
  BreakupBall({
    required Color color,
    double radius = 0,
    Vector2? position,
  }) : super(
          paint: PaletteEntry(color).paint(),
          bodyDef: BodyDef(
            type: BodyType.dynamic,
            position: position,
            fixedRotation: true,
            bullet: true,
          ),
          fixtureDefs: [
            FixtureDef(
              CircleShape()..radius = radius,
              restitution: 1,
              friction: 0.25,
            ),
          ],
        ) {
    bodyDef?.userData = this;
  }

  final _targetSpeed = 20.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    body.applyLinearImpulse(
      Vector2(
        (Random().nextDouble() * 1.8) - 0.9,
        -1,
      ),
    );
  }

  @override
  void update(double dt) {
    final deltaSpeed = _targetSpeed - body.linearVelocity.length;
    if (deltaSpeed != 0) {
      final direction = body.linearVelocity.normalized();
      // Imuplse = change in momentum and momentum is mass * velocity.
      body.applyLinearImpulse(direction * deltaSpeed * body.mass);
    }

    super.update(dt);
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);

    if (other is BreakupBrick) {
      other.removeFromParent();
    } else if (other is BreakupWalls &&
        (contact.fixtureA.isSensor || contact.fixtureB.isSensor)) {
      parent.reset();
    }
  }
}
