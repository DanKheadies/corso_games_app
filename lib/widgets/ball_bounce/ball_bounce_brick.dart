import 'dart:math';

import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
// import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class BallBounceBrick extends PositionComponent
    with CollisionCallbacks, HasGameRef<BallBounceGame> {
  BallBounceBrick({
    required this.brickValue,
    required this.brickRow,
    required this.brickColumn,
    required this.context,
    required double size,
  }) : super(
          size: Vector2.all(size),
        );

  int brickValue;
  int brickRow;
  int brickColumn;
  bool hasCollided = false;
  final BuildContext context;

  late final TextComponent brickText;
  late final RectangleHitbox rectangleBrickHitBox;
  late final RectangleComponent rectangleBrick;

  @override
  Future<void> onLoad() async {
    if (brickValue <= 0) {
      removeFromParent();
      return;
    }

    brickText = createBrickTextComponent(context);
    rectangleBrick = createBrickRectangleComponent();
    rectangleBrickHitBox = createBrickRectangleHitbox();

    addAll([
      rectangleBrick,
      rectangleBrickHitBox,
      brickText,
    ]);
  }

  @override
  void update(double dt) {
    if (hasCollided) {
      brickText.text = '$brickValue';
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BallBounceBall && !hasCollided) {
      hasCollided = true;
      handleCollision();
    }
    super.onCollision(intersectionPoints, other);
  }

  bool generateWithProbability(double percent) {
    final Random rand = Random();

    var randomInt = rand.nextInt(100) + 1; // generate a number 1-100 inclusive

    if (randomInt <= percent) {
      return true;
    }

    return false;
  }

  TextComponent createBrickTextComponent(BuildContext context) {
    return TextComponent(
      text: generateBrickText(),
      textRenderer: TextPaint(
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontSize: 20,
        ),
      ),
    )..center = size / 2;
  }

  String generateBrickText() {
    if (generateWithProbability(15)) {
      if (kIsWeb) {
        return '<>';
      } else {
        return '💣';
      }
    } else if (generateWithProbability(15)) {
      if (kIsWeb) {
        return '||';
      } else {
        return '🧨';
      }
    } else {
      return '$brickValue';
    }
  }

  RectangleHitbox createBrickRectangleHitbox() {
    return RectangleHitbox(
      size: size,
    );
  }

  RectangleComponent createBrickRectangleComponent() {
    return RectangleComponent(
      size: size,
      paint: Paint()
        ..style = PaintingStyle.fill
        ..color = Theme.of(context).colorScheme.tertiary,
    );
  }

  void handleCollision() {
    if (kIsWeb && brickText.text == '<>') {
      gameRef.removeBrickLayerRow(brickRow);
      // FlameAudio.play(brickRowRemoverAudio); // TODO
      return;
    } else if (brickText.text == '💣') {
      gameRef.removeBrickLayerRow(brickRow);
      // FlameAudio.play(brickRowRemoverAudio); // TODO
      return;
    }

    if (kIsWeb && brickText.text == '||') {
      gameRef.removeBrickLayerColumn(brickColumn);
      // FlameAudio.play(brickRowRemoverAudio); // TODO
      return;
    } else if (brickText.text == '🧨') {
      gameRef.removeBrickLayerColumn(brickColumn);
      // FlameAudio.play(brickRowRemoverAudio); // TODO
      return;
    }

    // FlameAudio.play(ballAudio);

    if (--brickValue == 0) {
      removeFromParent();
      return;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (hasCollided) {
      hasCollided = false;
    }
    super.onCollisionEnd(other);
  }
}
