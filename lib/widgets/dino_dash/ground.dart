import 'package:flutter/widgets.dart';

import 'package:corso_games_app/models/dino_dash/sprite.dart';
import 'package:corso_games_app/widgets/dino_dash/constants.dart';
import 'package:corso_games_app/widgets/dino_dash/game_object.dart';

Sprite groundSprite = Sprite(
  imagePath: 'assets/images/dino_dash/ground.png',
  imageWidth: 2399,
  imageHeight: 24,
);

class Ground extends GameObject {
  Ground({
    required this.worldLocation,
  });

  final Offset worldLocation;

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worldToPixelRatio,
      screenSize.height / 2 - groundSprite.imageHeight,
      groundSprite.imageWidth.toDouble(),
      groundSprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(groundSprite.imagePath);
  }
}
