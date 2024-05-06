import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

List<Sprite> pteraFrames = [
  Sprite(
    imagePath: 'assets/images/dino_dash/ptera/ptera_1.png',
    imageHeight: 80,
    imageWidth: 92,
  ),
  Sprite(
    imagePath: 'assets/images/dino_dash/ptera/ptera_2.png',
    imageHeight: 80,
    imageWidth: 92,
  ),
];

class Ptera extends GameObject {
  Ptera({
    required this.worldLocation,
  });

  final Offset worldLocation;
  int frame = 0;

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * worldToPixelRatio,
      4 / 7 * screenSize.height -
          pteraFrames[frame].imageHeight -
          worldLocation.dy,
      pteraFrames[frame].imageWidth.toDouble(),
      pteraFrames[frame].imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(
      pteraFrames[frame].imagePath,
      gaplessPlayback: true,
    );
  }

  @override
  void update(Duration lastTime, Duration currentTime) {
    frame = (currentTime.inMilliseconds / 200).floor() % 2;
  }
}
