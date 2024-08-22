import 'dart:async';

import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BreakupWorld extends Forge2DWorld with HasGameReference<BreakupGame> {
  BreakupWorld()
      : super(
          gravity: Vector2.zero(),
        );

  @override
  FutureOr<void> onLoad() async {
    // await add(
    //   BodyComponent(
    //     bodyDef: BodyDef(
    //       type: BodyType.dynamic,
    //     ),
    //     fixtureDefs: [
    //       FixtureDef(
    //         CircleShape()..radius = 20 * BreakupGame.lengthFactor,
    //       ),
    //     ],
    //   ),
    // );
    await add(
      BreakupWalls(
        game.camera.viewport.virtualSize,
        5 * BreakupGame.lengthFactor,
      ),
    );

    return super.onLoad();
  }
}
