import 'package:flame_forge2d/flame_forge2d.dart';

class BreakupWalls extends BodyComponent {
  BreakupWalls(
    Vector2 gameSize,
    double wallThickness,
  ) : super(
          bodyDef: BodyDef(
            type: BodyType.static,
          ),
          fixtureDefs: [
            FixtureDef(
              // Top
              PolygonShape()
                ..setAsBox(
                  gameSize.x * 0.5,
                  wallThickness * 0.5,
                  Vector2(
                    0,
                    -gameSize.y * 0.5,
                  ),
                  0,
                ),
              restitution: 1,
            ),
            FixtureDef(
              // Left
              PolygonShape()
                ..setAsBox(
                  wallThickness * 0.5,
                  gameSize.y * 0.5,
                  Vector2(
                    -gameSize.x * 0.5,
                    0,
                  ),
                  0,
                ),
              restitution: 1,
            ),
            FixtureDef(
              // Right
              PolygonShape()
                ..setAsBox(
                  wallThickness * 0.5,
                  gameSize.y * 0.5,
                  Vector2(
                    gameSize.x * 0.5,
                    0,
                  ),
                  0,
                ),
              restitution: 1,
            ),
            FixtureDef(
              // Bottom
              PolygonShape()
                ..setAsBox(
                  gameSize.x * 0.5,
                  wallThickness * 0.5,
                  Vector2(
                    0,
                    gameSize.y * 0.5,
                  ),
                  0,
                ),
              isSensor: true,
            ),
          ],
        ) {
    bodyDef?.userData = this;
  }
}
