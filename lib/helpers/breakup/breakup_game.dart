import 'dart:async';

import 'package:corso_games_app/helpers/helpers.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BreakupGame extends Forge2DGame<BreakupWorld>
    with HasKeyboardHandlerComponents, PanDetector, DragCallbacks {
  BreakupGame()
      : super(
          world: BreakupWorld(),
          camera: CameraComponent.withFixedResolution(
            width: 180 * lengthFactor,
            height: 320 * lengthFactor,
          ),
        );

  /// The ratio of forge2d units to virtual resolution units.
  static const lengthFactor = 0.1;

  @override
  FutureOr<void> onLoad() {
    camera.viewfinder.zoom = 1.0;

    return super.onLoad();
  }
}
