import 'package:flutter/material.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class Piece {
  /// Type of pixel art piece.
  final BaebPixelArt type;
  final int colLength;
  final int rowLength;
  final double? offset;

  Piece({
    required this.type,
    required this.colLength,
    required this.rowLength,
    this.offset,
  });

  /// The piece as a list of integers.
  List<int> position = [];

  /// Color of the piece.
  Color get color {
    return pixelColors[type] ?? Colors.white;
  }

  /// Places the piece at the boards "true center" after incorporating the piece's
  /// dimensions and applying any needed offset. Offset is from 0-1, where 0 is
  /// the bottom, 0.5 is back to center, and 1 is at the top.
  int trueCenter(int height, int width) {
    int boardCenter = ((rowLength * colLength) / 2).floor();
    if (offset != null) {
      boardCenter =
          (boardCenter - (rowLength * (colLength * (offset! - 0.5)).floor())) -
              (width / 2).floor() -
              ((height / 2).floor() * rowLength);
    } else {
      boardCenter = boardCenter -
          (width / 2).floor() -
          ((height / 2).floor() * rowLength);
    }

    return boardCenter;
  }

  /// Generate the integers.
  void initializePiece() {
    switch (type) {
      case BaebPixelArt.three:
        int height = 5;
        int width = 3;
        position = [
          0 + trueCenter(height, width),
          1 + trueCenter(height, width),
          2 + trueCenter(height, width),
          2 + rowLength + trueCenter(height, width),
          1 + rowLength * 2 + trueCenter(height, width),
          2 + rowLength * 2 + trueCenter(height, width),
          2 + rowLength * 3 + trueCenter(height, width),
          0 + rowLength * 4 + trueCenter(height, width),
          1 + rowLength * 4 + trueCenter(height, width),
          2 + rowLength * 4 + trueCenter(height, width),
        ];
        break;
      case BaebPixelArt.two:
        int height = 5;
        int width = 3;
        position = [
          0 + trueCenter(height, width),
          1 + trueCenter(height, width),
          2 + trueCenter(height, width),
          2 + rowLength + trueCenter(height, width),
          0 + rowLength * 2 + trueCenter(height, width),
          1 + rowLength * 2 + trueCenter(height, width),
          2 + rowLength * 2 + trueCenter(height, width),
          0 + rowLength * 3 + trueCenter(height, width),
          0 + rowLength * 4 + trueCenter(height, width),
          1 + rowLength * 4 + trueCenter(height, width),
          2 + rowLength * 4 + trueCenter(height, width),
        ];
        break;
      case BaebPixelArt.one:
        int height = 5;
        int width = 1;
        position = [
          0 + trueCenter(height, width),
          0 + rowLength + trueCenter(height, width),
          0 + rowLength * 2 + trueCenter(height, width),
          0 + rowLength * 3 + trueCenter(height, width),
          0 + rowLength * 4 + trueCenter(height, width),
        ];
        break;
      case BaebPixelArt.heart1:
        int height = 5;
        int width = 5;
        position = [
          0 + trueCenter(height, width),
          4 + trueCenter(height, width),
          0 + rowLength + trueCenter(height, width),
          1 + rowLength + trueCenter(height, width),
          2 + rowLength + trueCenter(height, width),
          3 + rowLength + trueCenter(height, width),
          4 + rowLength + trueCenter(height, width),
          1 + rowLength * 2 + trueCenter(height, width),
          3 + rowLength * 2 + trueCenter(height, width),
          1 + rowLength * 3 + trueCenter(height, width),
          3 + rowLength * 3 + trueCenter(height, width),
          2 + rowLength * 4 + trueCenter(height, width),
        ];
        break;
      case BaebPixelArt.heart2:
        int height = 7;
        int width = 9;
        position = [
          1 + trueCenter(height, width),
          3 + trueCenter(height, width),
          5 + trueCenter(height, width),
          7 + trueCenter(height, width),
          0 + rowLength + trueCenter(height, width),
          4 + rowLength + trueCenter(height, width),
          8 + rowLength + trueCenter(height, width),
          0 + rowLength * 2 + trueCenter(height, width),
          8 + rowLength * 2 + trueCenter(height, width),
          2 + rowLength * 3 + trueCenter(height, width),
          6 + rowLength * 3 + trueCenter(height, width),
          2 + rowLength * 5 + trueCenter(height, width),
          6 + rowLength * 5 + trueCenter(height, width),
          4 + rowLength * 6 + trueCenter(height, width),
        ];
        break;
      case BaebPixelArt.heart3:
        int height = 9;
        int width = 12;
        position = [
          2 + trueCenter(height, width),
          4 + trueCenter(height, width),
          8 + trueCenter(height, width),
          10 + trueCenter(height, width),
          0 + rowLength * 2 + trueCenter(height, width),
          6 + rowLength * 2 + trueCenter(height, width),
          12 + rowLength * 2 + trueCenter(height, width),
          0 + rowLength * 4 + trueCenter(height, width),
          12 + rowLength * 4 + trueCenter(height, width),
          2 + rowLength * 6 + trueCenter(height, width),
          10 + rowLength * 6 + trueCenter(height, width),
          4 + rowLength * 8 + trueCenter(height, width),
          8 + rowLength * 8 + trueCenter(height, width),
          6 + rowLength * 9 + trueCenter(height, width),
        ];
        break;
      case BaebPixelArt.pixel:
        position = [0 + (colLength * rowLength) - (rowLength / 2).ceil()];
        break;
      case BaebPixelArt.baeb:
        position = [
          0,
          1,
          2,
          5,
          8,
          9,
          10,
          12,
          13,
          14,
          0 + rowLength,
          2 + rowLength,
          4 + rowLength,
          6 + rowLength,
          8 + rowLength,
          12 + rowLength,
          14 + rowLength,
          0 + rowLength * 2,
          1 + rowLength * 2,
          4 + rowLength * 2,
          5 + rowLength * 2,
          6 + rowLength * 2,
          8 + rowLength * 2,
          9 + rowLength * 2,
          12 + rowLength * 2,
          13 + rowLength * 2,
          0 + rowLength * 3,
          2 + rowLength * 3,
          4 + rowLength * 3,
          6 + rowLength * 3,
          8 + rowLength * 3,
          12 + rowLength * 3,
          14 + rowLength * 3,
          0 + rowLength * 4,
          1 + rowLength * 4,
          2 + rowLength * 4,
          4 + rowLength * 4,
          6 + rowLength * 4,
          8 + rowLength * 4,
          9 + rowLength * 4,
          10 + rowLength * 4,
          12 + rowLength * 4,
          13 + rowLength * 4,
          14 + rowLength * 4,
        ];
        break;
    }
  }

  /// Move piece.
  void movePiece(BaebPixelDirection direction) {
    switch (direction) {
      case BaebPixelDirection.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case BaebPixelDirection.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case BaebPixelDirection.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      case BaebPixelDirection.up:
        for (int i = 0; i < position.length; i++) {
          position[i] -= rowLength;
        }
        break;
    }
  }
}
