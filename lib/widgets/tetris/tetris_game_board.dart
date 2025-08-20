import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

/// Create the game board with pieces.
List<List<Tetromino?>> gameBoard = List.generate(
  tetrisColLength,
  (i) => List.generate(tetrisRowLength, (j) => null),
);

/// A 2x2 grid with null representing an empty space.
/// A non empty space will have the color to represent landed pieces.
class TetrisGameBoard extends StatefulWidget {
  final double screenHeight;

  const TetrisGameBoard({
    super.key,
    required this.screenHeight,
  });

  @override
  State<TetrisGameBoard> createState() => _TetrisGameBoardState();
}

class _TetrisGameBoardState extends State<TetrisGameBoard> {
  bool gameOver = false;
  double bottomBar = 60;
  double topBar = 100;
  int currentScore = 0;
  int speedNormal = 400;
  int speedUp = 100;

  // current tetris piece
  TetrisPiece currentTetrisPiece = TetrisPiece(type: Tetromino.L);

  late Timer gameLoopTimer;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      topBar = 120;
    }

    // Start game on app start
    startGame();
  }

  @override
  void dispose() {
    gameLoopTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Note: constantly tapping "pauses" movement (bug vs feature)
      // Somewhere is responding to the tap and preventing the timer from going.
      body: GestureDetector(
        onTap: gameOver ? () => showGameOverDialog() : () {},
        onLongPress: gameOver
            ? () {}
            : () {
                // print('long press start');
                gameLoopTimer.cancel();
                gameLoop(speedUp);
              },
        onLongPressEnd: gameOver
            ? (_) {}
            : (details) {
                // print('long press end');
                gameLoopTimer.cancel();
                gameLoop(speedNormal);
              },
        onLongPressCancel: gameOver
            ? () {}
            : () {
                // print('long press cancel');
                gameLoopTimer.cancel();
                gameLoop(speedNormal);
              },
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onDoubleTap: gameOver
                    ? () {}
                    : () {
                        gameLoopTimer.cancel();
                        showPauseDialog();
                      },
                child: SizedBox(
                  // color: Colors.red,
                  width: 0.5575 * (widget.screenHeight - bottomBar - topBar),
                  child: Center(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: tetrisRowLength,
                      ),
                      itemCount: tetrisRowLength * tetrisColLength,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // Get row and col of each index
                        int row = (index / tetrisRowLength).floor();
                        int col = index % tetrisRowLength;

                        if (currentTetrisPiece.position.contains(index)) {
                          // Current piece
                          return TetrisPixel(
                            color: currentTetrisPiece.color,
                            // child: index.toString(),
                          );
                        } else if (gameBoard[row][col] != null) {
                          // Landed pieces
                          final Tetromino? tetrominoType = gameBoard[row][col];
                          return TetrisPixel(
                            color: tetrominoColors[tetrominoType]!,
                            // child: index.toString(),
                          );
                        } else {
                          // Blank pixel
                          return TetrisPixel(
                              // color: Colors.grey[900]!,
                              color:
                                  Theme.of(context).colorScheme.inverseSurface
                              // child: index.toString(),
                              );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            // GestureDetector(
            //   onDoubleTap: () {
            //     gameLoopTimer.cancel();
            //     showPauseDialog();
            //   },
            //   child: Text(
            //     'Score: $currentScore',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Score: $currentScore',
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TetrisButton(
                      icon: Icons.arrow_back_ios,
                      iconOffset: 10,
                      onTap: moveLeft,
                    ),
                    TetrisButton(
                      icon: Icons.rotate_right,
                      onTap: rotateTetrisPiece,
                    ),
                    TetrisButton(
                      icon: Icons.arrow_forward_ios,
                      iconOffset: 2,
                      onTap: moveRight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startGame() {
    currentTetrisPiece.initializeTetrisPiece();

    // Frame refresh rate
    gameLoop(speedNormal);
  }

  // Loop that keeps the pieces moving
  void gameLoop(int frameRate) {
    gameLoopTimer = Timer.periodic(Duration(milliseconds: frameRate), (timer) {
      if (!gameOver) {
        setState(() {
          // Clear lines
          clearLines();

          // Check landing
          checkLanding();

          // Check for game over
          if (gameOver) {
            gameLoopTimer.cancel();
            timer.cancel();
            showGameOverDialog();
          }

          // Move the current piece down
          currentTetrisPiece.moveTetrisPiece(TetrisDirection.down);
        });
      } else {
        gameLoopTimer.cancel();
        timer.cancel();
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Game Over',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        content: Text(
          'Your score is: $currentScore',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.goNamed('games'),
            child: Text('To Games'),
          ),
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.of(context).pop();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void showPauseDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Pause',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        content: Text(
          'Your score is: $currentScore',
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          TextButton(
            onPressed: () => context.goNamed('games'),
            child: Text('To Games'),
          ),
          TextButton(
            onPressed: () {
              gameLoop(speedNormal);
              Navigator.of(context).pop();
            },
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    // Clear the game board
    gameBoard = List.generate(
      tetrisColLength,
      (i) => List.generate(tetrisRowLength, (j) => null),
    );

    gameOver = false;
    currentScore = 0;

    createNewTetrisPiece();

    startGame();
  }

  /// Check for collision in the future position.
  /// Return true -> there is a collision
  /// return false -> there is no collision
  bool checkForCollision(TetrisDirection direction) {
    // Loop through each position of the current piece
    for (int i = 0; i < currentTetrisPiece.position.length; i++) {
      // Calculate the row and column of the current position.
      int row = (currentTetrisPiece.position[i] / tetrisRowLength).floor();
      int col = currentTetrisPiece.position[i] % tetrisRowLength;

      // Adjust the row and col based on the direction.
      if (direction == TetrisDirection.left) {
        col -= 1;
      } else if (direction == TetrisDirection.right) {
        col += 1;
      } else if (direction == TetrisDirection.down) {
        row += 1;
      }

      // Check if the piece is out of bounds, i.e. too low or far left / right.
      if (row >= tetrisColLength || col < 0 || col >= tetrisRowLength) {
        return true;
      }

      // Check if the position is occupied by another piece.
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }

    // If no collections are detected, return false.
    return false;
  }

  void checkLanding() {
    // If going down is occupied..
    if (checkForCollision(TetrisDirection.down)) {
      // Mark position as occupied on the gameboard.
      for (int i = 0; i < currentTetrisPiece.position.length; i++) {
        // Calculate the row and column of the current position.
        int row = (currentTetrisPiece.position[i] / tetrisRowLength).floor();
        int col = currentTetrisPiece.position[i] % tetrisRowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentTetrisPiece.type;
        }
      }

      // Once it lands, create the next piece.
      createNewTetrisPiece();
    }
  }

  void createNewTetrisPiece() {
    // Create a random object to generate rando Tetromino types.
    Random rand = Random();

    // Create a new piece with a random type.
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentTetrisPiece = TetrisPiece(type: randomType);
    currentTetrisPiece.initializeTetrisPiece();

    // The game is over when there's a piece at the top level. We'll check if
    // there's a piece at the top when we create a new piece instead of every
    // frame. New piees can go through the top, but if there's a piece there,
    // it should be game over.
    if (isGameOver()) {
      setState(() {
        gameOver = true;
      });
    }
  }

  void moveDown() {
    // Make sure the move is valid before moving.
    if (!checkForCollision(TetrisDirection.left)) {
      setState(() {
        currentTetrisPiece.moveTetrisPiece(TetrisDirection.down);
      });
    }
  }

  void moveLeft() {
    // Make sure the move is valid before moving.
    if (!checkForCollision(TetrisDirection.left)) {
      setState(() {
        currentTetrisPiece.moveTetrisPiece(TetrisDirection.left);
      });
    }
  }

  void moveRight() {
    // Make sure the move is valid before moving.
    if (!checkForCollision(TetrisDirection.right)) {
      setState(() {
        currentTetrisPiece.moveTetrisPiece(TetrisDirection.right);
      });
    }
  }

  void rotateTetrisPiece() {
    setState(() {
      currentTetrisPiece.rotateTetrisPiece();
    });
  }

  void clearLines() {
    // 1: Loop thru row of the game board from bottom to top.
    for (int row = tetrisColLength - 1; row >= 0; row--) {
      // 2: Initialize a variable to track if the row is full.
      bool rowIsFull = true;

      // 3: Check if the row is full, i.e. all cols have a filled piece.
      for (int col = 0; col < tetrisRowLength; col++) {
        // If there's an empty column, rowIsNotFull so false and break.
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // 4: Row is full, so clear and shift rows down.
      if (rowIsFull) {
        // 5: Move all rows above the cleared row down one level.
        for (int r = row; r > 0; r--) {
          // Copy the above row to the current row.
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // 6: Set the top row to empty.
        gameBoard[0] = List.generate(row, (index) => null);

        // 7: Increase the score.
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    // Check if any columns in the top row are filled.
    for (int col = 0; col < tetrisRowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // If the top row is empty, game is still going.
    return false;
  }
}
