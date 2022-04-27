import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:corso_games_app/models/dino_dash/sprite.dart';
import 'package:corso_games_app/widgets/dino_dash/constants.dart';
import 'package:corso_games_app/widgets/dino_dash/game_object.dart';

List<Sprite> cacti = [
  Sprite(
    imagePath: 'assets/images/dino_dash/cacti/cacti_group.png',
    imageWidth: 104,
    imageHeight: 100,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/cacti/cacti_large_1.png',
    imageWidth: 50,
    imageHeight: 100,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/cacti/cacti_large_2.png',
    imageWidth: 98,
    imageHeight: 100,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/cacti/cacti_small_1.png',
    imageWidth: 34,
    imageHeight: 70,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/cacti/cacti_small_2.png',
    imageWidth: 68,
    imageHeight: 70,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/cacti/cacti_small_3.png',
    imageWidth: 107,
    imageHeight: 70,
  ),
];

class Cactus extends GameObject {
  Cactus({
    required this.worldLocation,
  }) : sprite = cacti[Random().nextInt(cacti.length)];

  late Sprite sprite;
  late Offset worldLocation;

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worldToPixelRatio,
      screenSize.height / 2 - sprite.imageHeight,
      sprite.imageWidth.toDouble(),
      sprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(sprite.imagePath);
  }
}
