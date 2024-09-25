import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BreakupBrick extends BodyComponent {
  BreakupBrick({
    required Color color,
    required Vector2 position,
    required Vector2 size,
  }) : super(
          paint: PaletteEntry(color).paint(),
          bodyDef: BodyDef(
            type: BodyType.static,
            position: position,
          ),
          fixtureDefs: [
            FixtureDef(
              PolygonShape()
                ..setAsBoxXY(
                  size.x + 0.5,
                  size.y + 0.5,
                ),
              restitution: 1,
            ),
          ],
        ) {
    bodyDef?.userData = this;
  }
}
