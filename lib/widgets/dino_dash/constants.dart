import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/dino_dash/cactus.dart';
import 'package:corso_games_app/widgets/dino_dash/cloud.dart';
import 'package:corso_games_app/widgets/dino_dash/ground.dart';

const int gravityPPSS = 1420;
const int worldToPixelRatio = 10;

List<Cactus> initCacti = [
  Cactus(worldLocation: const Offset(200, 0)),
];

List<Cloud> initClouds = [
  Cloud(worldLocation: const Offset(100, 20)),
  Cloud(worldLocation: const Offset(200, 10)),
  Cloud(worldLocation: const Offset(350, -10)),
];

List<Ground> initGround = [
  Ground(worldLocation: const Offset(0, 0)),
  Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0)),
];
