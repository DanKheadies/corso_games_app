import 'package:flutter/material.dart';

enum BaebPixelDirection { down, left, right, up }

enum BaebPixelArt { three, two, one, pixel, heart1, heart2, heart3, baeb }

// int colLength = 15; // 16
// int rowLength = 35; // 32

const Map<BaebPixelArt, Color> pixelColors = {
  BaebPixelArt.three: Color.fromARGB(255, 0, 102, 255),
  BaebPixelArt.two: Color(0xFF008000),
  BaebPixelArt.one: Color(0xFFffff00),
  BaebPixelArt.pixel: Color(0xFFffffff),
  BaebPixelArt.heart1: Color.fromARGB(255, 144, 0, 255),
  BaebPixelArt.heart2: Color.fromARGB(255, 242, 0, 255),
  BaebPixelArt.heart3: Color(0xFFff0000),
  BaebPixelArt.baeb: Color(0xFFffa500),
};
