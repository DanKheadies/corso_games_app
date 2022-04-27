import 'package:flutter/widgets.dart';

import 'package:corso_games_app/models/dino_dash/sprite.dart';
import 'package:corso_games_app/widgets/dino_dash/constants.dart';
import 'package:corso_games_app/widgets/dino_dash/game_object.dart';

List<Sprite> dino = [
  Sprite(
    imagePath: 'assets/images/dino_dash/dino/dino_1.png',
    imageWidth: 88,
    imageHeight: 94,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/dino/dino_2.png',
    imageWidth: 88,
    imageHeight: 94,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/dino/dino_3.png',
    imageWidth: 88,
    imageHeight: 94,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/dino/dino_4.png',
    imageWidth: 88,
    imageHeight: 94,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/dino/dino_5.png',
    imageWidth: 88,
    imageHeight: 94,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/dino/dino_6.png',
    imageWidth: 88,
    imageHeight: 94,
  ),
];

enum DinoState {
  jumping,
  running,
  dead,
}

class Dino extends GameObject {
  Sprite currentSprite = dino[0];
  bool isDead = false;
  double dispY = 0;
  double velY = 0;
  DinoState state = DinoState.running;

  @override
  Widget render() {
    return Image.asset(currentSprite.imagePath);
  }

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      screenSize.width / 10,
      screenSize.height / 2 - currentSprite.imageHeight - dispY,
      currentSprite.imageWidth.toDouble(),
      currentSprite.imageHeight.toDouble(),
    );
  }

  @override
  void update(Duration lastTime, Duration currentTime) {
    currentSprite = dino[(currentTime.inMilliseconds / 100).floor() % 2 + 2];

    double elapsedTimeSeconds = (currentTime - lastTime).inMilliseconds / 1000;

    dispY += velY * elapsedTimeSeconds;
    if (dispY <= 0) {
      dispY = 0;
      velY = 0;
      state = DinoState.running;
    } else {
      velY -= gravityPPSS * elapsedTimeSeconds;
    }
  }

  void jump() {
    if (state != DinoState.jumping) {
      state = DinoState.jumping;
      velY = 750;
    }
  }

  void die() {
    currentSprite = dino[5];
    isDead = true;
    state = DinoState.dead;
  }

  void reset() {
    currentSprite = dino[0];
    dispY = 0;
    velY = 0;
    isDead = false;
    state = DinoState.running;
  }
}
