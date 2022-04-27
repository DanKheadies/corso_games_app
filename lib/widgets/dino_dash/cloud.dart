import 'package:flutter/widgets.dart';

import 'package:corso_games_app/models/dino_dash/sprite.dart';
import 'package:corso_games_app/widgets/dino_dash/constants.dart';
import 'package:corso_games_app/widgets/dino_dash/game_object.dart';

Sprite cloudSprite = Sprite(
  imagePath: 'assets/images/dino_dash/cloud.png',
  imageWidth: 92,
  imageHeight: 27,
);

class Cloud extends GameObject {
  Cloud({
    required this.worldLocation,
  });
  final Offset worldLocation;

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worldToPixelRatio / 5,
      screenSize.height / 5 - cloudSprite.imageHeight - worldLocation.dy,
      cloudSprite.imageWidth.toDouble(),
      cloudSprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(cloudSprite.imagePath);
  }
}
