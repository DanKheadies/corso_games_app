import 'package:flutter/material.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class TetrisPiece {
  /// Type of tetris piece
  final Tetromino type;

  TetrisPiece({required this.type});

  /// The piece as a list of integers.
  List<int> position = [];

  /// Color of the piece.
  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  /// Generate the integers.
  void initializeTetrisPiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          4 - tetrisRowLength * 2,
          14 - tetrisRowLength * 2,
          24 - tetrisRowLength * 2,
          25 - tetrisRowLength * 2,
        ];
        break;
      case Tetromino.J:
        position = [
          5 - tetrisRowLength * 2,
          15 - tetrisRowLength * 2,
          24 - tetrisRowLength * 2,
          25 - tetrisRowLength * 2,
        ];
        break;
      case Tetromino.I:
        position = [
          4 - tetrisRowLength * 2,
          14 - tetrisRowLength * 2,
          24 - tetrisRowLength * 2,
          34 - tetrisRowLength * 2,
        ];
        break;
      case Tetromino.O:
        position = [
          4 - tetrisRowLength * 2,
          5 - tetrisRowLength * 2,
          14 - tetrisRowLength * 2,
          15 - tetrisRowLength * 2,
        ];
        break;
      case Tetromino.S:
        position = [
          5 - tetrisRowLength * 2,
          6 - tetrisRowLength * 2,
          14 - tetrisRowLength * 2,
          15 - tetrisRowLength * 2,
        ];
        break;
      case Tetromino.Z:
        position = [
          4 - tetrisRowLength * 2,
          5 - tetrisRowLength * 2,
          15 - tetrisRowLength * 2,
          16 - tetrisRowLength * 2,
        ];
        break;
      case Tetromino.T:
        position = [
          4 - tetrisRowLength * 2,
          5 - tetrisRowLength * 2,
          6 - tetrisRowLength * 2,
          15 - tetrisRowLength * 2,
        ];
        break;
    }
  }

  /// Move piece.
  void moveTetrisPiece(TetrisDirection direction) {
    switch (direction) {
      case TetrisDirection.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += tetrisRowLength;
        }
        break;
      case TetrisDirection.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case TetrisDirection.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
    }
  }

  int rotationState = 1;

  /// Rotate piece.
  void rotateTetrisPiece() {
    // New position
    List<int> newPosition = [];

    // Rotate the piece (clockwise) based on it's type.
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          // Upright L
          case 0:
            newPosition = [
              position[1] - tetrisRowLength,
              position[1],
              position[1] + tetrisRowLength,
              position[1] + tetrisRowLength + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Gun L to the right
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + tetrisRowLength - 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // L down
          case 2:
            newPosition = [
              position[1] + tetrisRowLength,
              position[1],
              position[1] - tetrisRowLength,
              position[1] - tetrisRowLength - 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // L to the right
          case 3:
            newPosition = [
              position[1] - tetrisRowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
        }

      case Tetromino.J:
        switch (rotationState) {
          // Upright J
          case 0:
            newPosition = [
              position[1] - tetrisRowLength,
              position[1],
              position[1] + tetrisRowLength,
              position[1] + tetrisRowLength - 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // J laying on the ground
          case 1:
            newPosition = [
              position[1] - tetrisRowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // J down
          case 2:
            newPosition = [
              position[1] + tetrisRowLength,
              position[1],
              position[1] - tetrisRowLength,
              position[1] - tetrisRowLength + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // J gun to the left
          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + tetrisRowLength + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
        }

      case Tetromino.I:
        switch (rotationState) {
          // Horizontal
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Vertical
          case 1:
            newPosition = [
              position[1] - tetrisRowLength,
              position[1],
              position[1] + tetrisRowLength,
              position[1] + 2 * tetrisRowLength,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Horizontal again
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Vertical again
          case 3:
            newPosition = [
              position[1] + tetrisRowLength,
              position[1],
              position[1] - tetrisRowLength,
              position[1] - 2 * tetrisRowLength,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
        }

      case Tetromino.O:
        // No rotation
        break;

      case Tetromino.S:
        switch (rotationState) {
          // S to the right
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + tetrisRowLength - 1,
              position[1] + tetrisRowLength,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Top left, bottom right
          case 1:
            newPosition = [
              position[0] - tetrisRowLength,
              position[0],
              position[0] + 1,
              position[0] + tetrisRowLength + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // S to the right again
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + tetrisRowLength - 1,
              position[1] + tetrisRowLength,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Top left, bottom right again
          case 3:
            newPosition = [
              position[0] - tetrisRowLength,
              position[0],
              position[0] + 1,
              position[0] + tetrisRowLength + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
        }

      case Tetromino.Z:
        switch (rotationState) {
          // Z to the left
          case 0:
            newPosition = [
              position[0] + tetrisRowLength - 2,
              position[1],
              position[2] + tetrisRowLength - 1,
              position[3] + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Top right, bottom left
          case 1:
            newPosition = [
              position[0] - tetrisRowLength + 2,
              position[1],
              position[2] - tetrisRowLength + 1,
              position[3] - 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Z to left again
          case 2:
            newPosition = [
              position[0] + tetrisRowLength - 2,
              position[1],
              position[2] + tetrisRowLength - 1,
              position[3] + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // Top right, bottom left again
          case 3:
            newPosition = [
              position[0] - tetrisRowLength + 2,
              position[1],
              position[2] - tetrisRowLength + 1,
              position[3] - 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
        }

      case Tetromino.T:
        switch (rotationState) {
          // T butt to the right
          case 0:
            newPosition = [
              position[2] - tetrisRowLength,
              position[2],
              position[2] + 1,
              position[2] + tetrisRowLength,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // T butt down
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + tetrisRowLength,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // T butt left
          case 2:
            newPosition = [
              position[1] - tetrisRowLength,
              position[1] - 1,
              position[1],
              position[1] + tetrisRowLength,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          // T butt up
          case 3:
            newPosition = [
              position[2] - tetrisRowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            // Check it's valid before changing the position.
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = 0;
            }
            break;
        }
        break;
    }
  }

  /// Check if a valid position.
  bool positionIsValid(int position) {
    // Get the row and col of the position.
    int row = (position / tetrisRowLength).floor();
    int col = position % tetrisRowLength;

    // If the position is taken or "out of bounds," return false.
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    return true;
  }

  /// Check if piece is in a valid position.
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      // Check if any positino is already taken.
      if (!positionIsValid(pos)) {
        return false;
      }

      // Get the col of each position.
      int col = pos % tetrisRowLength;

      // Check if the first or last column is occupied.
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == tetrisRowLength - 1) {
        lastColOccupied = true;
      }
    }

    // If there's a piece in the first and last col, it's thru the wall.
    return !(firstColOccupied && lastColOccupied);
  }
}
