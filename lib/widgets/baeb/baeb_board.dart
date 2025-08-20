import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:corso_games_app/widgets/widgets.dart';

/// A 2x2 grid with null representing an empty space.
/// A non empty space will have the color to represent art pieces.
class BaebBoard extends StatefulWidget {
  final bool isVertical;
  final double screenHeight;
  final double statusBarHeight;
  final int colLength;
  final int rowLength;
  final List<List<BaebPixelArt?>> gameBoard;
  final Function resetGameBoard;

  BaebBoard({
    super.key,
    required this.colLength,
    required this.isVertical,
    required this.rowLength,
    required this.resetGameBoard,
    required this.screenHeight,
    required this.statusBarHeight,
  }) : gameBoard = List.generate(
          colLength,
          (i) => List.generate(rowLength, (j) => null),
        );

  @override
  State<BaebBoard> createState() => _BaebBoardState();
}

class _BaebBoardState extends State<BaebBoard> {
  bool isGoingDown = true;
  bool isOver = false;
  double bottomBar = 60;
  double topBar = 100;
  double topPadding = 20;
  int frameRate = 1000;
  int speedNormal = 1000;
  int speedFast = 500;
  int speedFaster = 100;
  int sequenceFrame = 0;

  late Piece currentPiece;
  late Timer animaterTimer;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      topBar = 120;
    }

    currentPiece = Piece(
      type: BaebPixelArt.three,
      colLength: widget.colLength,
      rowLength: widget.rowLength,
    );
    currentPiece.initializePiece();

    // Start animation on app start
    // startAnimation();

    // Start animation w/ specified frame refresh rate.
    animater(speedNormal);
  }

  @override
  void dispose() {
    animaterTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => nextSequence(),
      // onLongPress: () => animaterTimer.cancel(),
      // onDoubleTap: () => Navigator.of(context).pop(),
      // onLongPress: () => Navigator.of(context).pop(),
      child: widget.isVertical
          ? Padding(
              padding: EdgeInsets.only(top: topPadding),
              child: Column(
                children: [
                  // Container(
                  //   color: Colors.black,
                  //   height: topBar,
                  //   padding: const EdgeInsets.only(top: 35),
                  //   width: double.infinity,
                  //   child: Opacity(
                  //     opacity:
                  //         sequenceFrame >= (widget.colLength * 0.8).floor() + 5
                  //             ? 1
                  //             : 0,
                  //     child: TextButton(
                  //       onPressed: () {
                  //         Navigator.of(context).pop();
                  //       },
                  //       child: Text(
                  //         'i like you',
                  //         style: TextStyle(color: Colors.white, fontSize: 24),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: SizedBox(
                      // color: Colors.teal,
                      width: 0.428 *
                          (widget.screenHeight -
                              bottomBar -
                              topBar -
                              topPadding * 2),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget.rowLength,
                          childAspectRatio: 1,
                        ),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: widget.rowLength * widget.colLength,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // Get row and col of each index
                          int row = (index / widget.rowLength).floor();
                          int col = index % widget.rowLength;

                          if (currentPiece.position.contains(index)) {
                            // Main piece
                            return BaebPixel(
                              color: currentPiece.color,
                              // child: index.toString(),
                            );
                          } else if (widget.gameBoard[row][col] != null) {
                            // Background pieces
                            final BaebPixelArt? pixelType =
                                widget.gameBoard[row][col];
                            return BaebPixel(
                              color: pixelColors[pixelType]!,
                              // child: index.toString(),
                            );
                          } else {
                            // Blank pixel
                            return BaebPixel(
                              // color: Colors.grey[900]!,
                              // color: Colors.black,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface,
                              // child: index.toString(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.black,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    height: bottomBar,
                    // height: widget.screenHeight * 0.05,
                    width: double.infinity,
                  ),
                ],
              ),
            )
          : Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    // color: Colors.black,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    child: IconButton(
                      icon: Icon(Icons.chevron_left, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.rowLength,
                    ),
                    shrinkWrap: true,
                    itemCount: widget.rowLength * widget.colLength,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // Get row and col of each index
                      int row = (index / widget.rowLength).floor();
                      int col = index % widget.rowLength;

                      if (currentPiece.position.contains(index)) {
                        // Main piece
                        return BaebPixel(
                          color: currentPiece.color,
                          // child: index.toString(),
                        );
                      } else if (widget.gameBoard[row][col] != null) {
                        // Background pieces
                        final BaebPixelArt? pixelType =
                            widget.gameBoard[row][col];
                        return BaebPixel(
                          color: pixelColors[pixelType]!,
                          // child: index.toString(),
                        );
                      } else {
                        // Blank pixel
                        return BaebPixel(
                          // color: Colors.grey[900]!,
                          // color: Colors.black,
                          color: Theme.of(context).colorScheme.onInverseSurface,
                          // child: index.toString(),
                        );
                      }
                    },
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      // color: Colors.black,
                    )),
              ],
            ),
    );
  }

  // void startAnimation() {
  //   currentPiece.initializePiece();

  //   // Frame refresh rate
  //   animater(speedNormal);
  // }

  // Loop that keeps the pieces moving
  void animater(int frameRate) {
    animaterTimer = Timer.periodic(Duration(milliseconds: frameRate), (timer) {
      // print('$sequenceFrame - $frameRate');
      nextSequence();

      // Check for game over
      if (isOver) {
        timer.cancel();
        showAnimationOverDialog();
      }
    });
  }

  void nextSequence() {
    swapArt();

    setState(() {
      sequenceFrame += 1;
    });
  }

  void swapColors() {
    Piece baebPiece = Piece(
      type: BaebPixelArt.baeb,
      colLength: widget.colLength,
      rowLength: widget.rowLength,
    );
    baebPiece.initializePiece();

    // Mark position as occupied on the gameboard.
    for (int i = 0; i < baebPiece.position.length; i++) {
      // Calculate the row and column of the current position.
      int row = (baebPiece.position[i] / widget.rowLength).floor();
      int col = baebPiece.position[i] % widget.rowLength;

      if (row >= 0 && col >= 0) {
        // Swap colors
        // print(sequenceFrame % 5);
        if (sequenceFrame % 5 == 0) {
          setState(() {
            widget.gameBoard[row][col] = baebPiece.type;
          });
        } else if (sequenceFrame % 5 == 1) {
          setState(() {
            widget.gameBoard[row][col] = BaebPixelArt.heart1;
          });
        } else if (sequenceFrame % 5 == 2) {
          setState(() {
            widget.gameBoard[row][col] = BaebPixelArt.heart2;
          });
        } else if (sequenceFrame % 5 == 3) {
          setState(() {
            widget.gameBoard[row][col] = BaebPixelArt.heart3;
          });
        } else if (sequenceFrame % 5 == 4) {
          setState(() {
            widget.gameBoard[row][col] = BaebPixelArt.three;
          });
        }
      }
    }
  }

  void showAnimationOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Huzzah!'),
        content: Text('Thanks for watching.'),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.of(context).pop();
            },
            child: Text('Watch again'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    // Clear the game board
    // widget.gameBoard = List.generate(
    //   colLength,
    //   (i) => List.generate(rowLength, (j) => null),
    // );
    widget.resetGameBoard();

    isOver = false;

    // startAnimation();
    // TODO: create BaebPixelArt.three and initialize
  }

  void swapArt() {
    // Create the next piece
    if (sequenceFrame == 0) {
      currentPiece = Piece(
        type: BaebPixelArt.three,
        colLength: widget.colLength,
        rowLength: widget.rowLength,
      );
      currentPiece.initializePiece();
    } else if (sequenceFrame == 1) {
      currentPiece = Piece(
        type: BaebPixelArt.two,
        colLength: widget.colLength,
        rowLength: widget.rowLength,
      );
      currentPiece.initializePiece();
    } else if (sequenceFrame == 2) {
      currentPiece = Piece(
        type: BaebPixelArt.one,
        colLength: widget.colLength,
        rowLength: widget.rowLength,
      );
      currentPiece.initializePiece();
    } else if (sequenceFrame > 2 &&
        sequenceFrame <= (widget.colLength * 0.8).floor()) {
      currentPiece = Piece(
        type: BaebPixelArt.pixel,
        colLength: widget.colLength,
        rowLength: widget.rowLength,
      );
      currentPiece.initializePiece();
      if (frameRate == speedNormal) {
        animaterTimer.cancel();
        setState(() {
          frameRate = speedFaster;
        });
        animater(speedFaster);
      }
    } else if (sequenceFrame == (widget.colLength * 0.8).floor() + 1) {
      if (frameRate == speedFaster) {
        animaterTimer.cancel();
        setState(() {
          frameRate = speedNormal;
        });
        animater(speedNormal);
      }
      currentPiece = Piece(
        type: BaebPixelArt.heart1,
        colLength: widget.colLength,
        rowLength: widget.rowLength,
        offset: 0.8,
      );
      currentPiece.initializePiece();
    } else if (sequenceFrame == (widget.colLength * 0.8).floor() + 2) {
      currentPiece = Piece(
        type: BaebPixelArt.heart2,
        colLength: widget.colLength,
        rowLength: widget.rowLength,
        offset: 0.69,
      );
      currentPiece.initializePiece();
    } else if (sequenceFrame == (widget.colLength * 0.8).floor() + 3) {
      currentPiece = Piece(
        type: BaebPixelArt.heart3,
        colLength: widget.colLength,
        rowLength: widget.rowLength,
      );
      currentPiece.initializePiece();
    }

    if (currentPiece.type == BaebPixelArt.heart3) {
      // If going down is occupied..
      if (isGoingDown) {
        if (checkForCollision(BaebPixelDirection.down)) {
          setState(() {
            currentPiece.movePiece(BaebPixelDirection.up);
            isGoingDown = false;
          });
        } else {
          setState(() {
            currentPiece.movePiece(BaebPixelDirection.down);
          });
        }
      } else {
        if (checkForCollision(BaebPixelDirection.up)) {
          setState(() {
            currentPiece.movePiece(BaebPixelDirection.down);
            isGoingDown = true;
          });
        } else {
          setState(() {
            currentPiece.movePiece(BaebPixelDirection.up);
          });
        }
      }
      // setState(() {
      //   currentPiece.movePiece(BaebPixelDirection.down);
      // });

      Piece baebPiece = Piece(
        type: BaebPixelArt.baeb,
        colLength: widget.colLength,
        rowLength: widget.rowLength,
      );
      baebPiece.initializePiece();

      // Mark position as occupied on the artboard.
      for (int i = 0; i < baebPiece.position.length; i++) {
        // Calculate the row and column of the current position.
        int row = (baebPiece.position[i] / widget.rowLength).floor();
        int col = baebPiece.position[i] % widget.rowLength;

        if (row >= 0 && col >= 0) {
          // Swap colors
          // print(sequenceFrame % 7);
          if (sequenceFrame % 7 == 0) {
            setState(() {
              widget.gameBoard[row][col] = baebPiece.type;
            });
          } else if (sequenceFrame % 7 == 1) {
            setState(() {
              widget.gameBoard[row][col] = BaebPixelArt.one;
            });
          } else if (sequenceFrame % 7 == 2) {
            setState(() {
              widget.gameBoard[row][col] = BaebPixelArt.two;
            });
          } else if (sequenceFrame % 7 == 3) {
            setState(() {
              widget.gameBoard[row][col] = BaebPixelArt.three;
            });
          } else if (sequenceFrame % 7 == 4) {
            setState(() {
              widget.gameBoard[row][col] = BaebPixelArt.heart1;
            });
          } else if (sequenceFrame % 7 == 5) {
            setState(() {
              widget.gameBoard[row][col] = BaebPixelArt.heart2;
            });
          } else if (sequenceFrame % 7 == 6) {
            setState(() {
              widget.gameBoard[row][col] = BaebPixelArt.heart3;
            });
          }
        }
      }
    } else if (currentPiece.type == BaebPixelArt.pixel) {
      // Note: framerate changes for pixel shooting up, e.g. 5x speed
      for (int i = 1; i < sequenceFrame - 2; i++) {
        setState(() {
          currentPiece.movePiece(BaebPixelDirection.up);
        });
      }
    }

    // setState(() {});
    // setState(() {
    //   sequenceFrame += 1;
    // });
  }

  /// Check for collision in the future position.
  /// Return true -> there is a collision
  /// return false -> there is no collision
  bool checkForCollision(BaebPixelDirection direction) {
    // Loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // Calculate the row and column of the current position.
      int row = (currentPiece.position[i] / widget.rowLength).floor();
      int col = currentPiece.position[i] % widget.rowLength;

      // Adjust the row and col based on the direction.
      // if (direction == BaebPixelDirection.left) {
      //   col -= 1;
      // } else if (direction == BaebPixelDirection.right) {
      //   col += 1;
      // } else
      if (direction == BaebPixelDirection.down) {
        row += 1;
      } else if (direction == BaebPixelDirection.up) {
        row -= 1;
      }

      // Check if the piece is out of bounds, i.e. too low or far left / right.
      if (row >= widget.colLength || col < 0 || col >= widget.rowLength) {
        return true;
      }

      // Check if the position is occupied by another piece.
      if (row >= 0 && col >= 0) {
        if (widget.gameBoard[row][col] != null) {
          return true;
        }
      }
    }

    // If no collections are detected, return false.
    return false;
  }

  bool isShowOver() {
    // // Check if any columns in the top row are filled.
    // for (int col = 0; col < rowLength; col++) {
    //   if (gameBoard[0][col] != null) {
    //     return true;
    //   }
    // }

    // // If the top row is empty, game is still going.
    return false;
  }
}
