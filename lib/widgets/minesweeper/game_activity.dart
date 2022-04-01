import 'dart:math';

import 'package:flutter/material.dart';

import 'package:corso_games_app/models/minesweeper/board_square.dart';

enum ImageType {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  bomb,
  facingDown,
  flagged,
}

class GameActivity extends StatefulWidget {
  const GameActivity({
    Key? key,
  }) : super(key: key);

  @override
  State<GameActivity> createState() => _GameActivityState();
}

class _GameActivityState extends State<GameActivity> {
  // TODO: math to make this relationship scale accordingly

  // iPhone 12 mini (h:60) (856 x 1,482) (1080 x 2340)
  // 8  x 12
  // 10 x 15
  // 12 x 18
  // 16 x 24

  // iPhone 12 Pro Max (h: 55) (720 x 1,098) (1284 x 2778)
  // 5  x 8
  // 10 x 16
  // 15 x 24
  // 20 x 32

  double headerHeight = 60;
  int columnCount = 10;
  int rowCount = 15;

  // bomb / max = %
  // 3 / 15 = 0.2
  int bombProbability = 3;
  int maxProbability = 15;

  int bombCount = 0;
  int squaresLeft = 0;

  List<List<BoardSquare>> board = [];
  List<bool> openedSquares = [];
  List<bool> flaggedSquares = [];

  @override
  void initState() {
    super.initState();
    initializeGame(bombProbability, maxProbability);
  }

  void initializeGame(int _bombProb, int _maxProb) {
    board = List.generate(rowCount, (i) {
      return List.generate(columnCount, (j) {
        return BoardSquare();
      });
    });

    openedSquares = List.generate(rowCount * columnCount, (i) {
      return false;
    });

    flaggedSquares = List.generate(rowCount * columnCount, (i) {
      return false;
    });

    bombCount = 0;
    squaresLeft = rowCount * columnCount;

    // Randomly generate bombs
    Random random = Random();
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        int randomNumber = random.nextInt(maxProbability);
        if (randomNumber < bombProbability) {
          board[i][j].hasBomb = true;
          bombCount++;
        }
      }
    }

    // Check bombs around and assign numbers
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (i > 0 && j > 0) {
          if (board[i - 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0) {
          if (board[i - 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0 && j < columnCount - 1) {
          if (board[i - 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j > 0) {
          if (board[i][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j < columnCount - 1) {
          if (board[i][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1 && j > 0) {
          if (board[i + 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1) {
          if (board[i + 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1 && j < columnCount - 1) {
          if (board[i + 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }
      }
    }

    setState(() {});
  }

  // This function opens other squares around the target square which don't have any bombs around them.
  // We use a recursive function which stops at squares which have a non zero number of bombs around them.
  void _handleTap(int i, int j) {
    int position = (i * columnCount) + j;
    openedSquares[position] = true;
    squaresLeft = squaresLeft - 1;

    if (i > 0) {
      if (!board[i - 1][j].hasBomb &&
          openedSquares[((i - 1) * columnCount) + j] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i - 1, j);
        }
      }
    }

    if (j > 0) {
      if (!board[i][j - 1].hasBomb &&
          openedSquares[(i * columnCount) + j - 1] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i, j - 1);
        }
      }
    }

    if (j < columnCount - 1) {
      if (!board[i][j + 1].hasBomb &&
          openedSquares[(i * columnCount) + j + 1] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i, j + 1);
        }
      }
    }

    if (i < rowCount - 1) {
      if (!board[i + 1][j].hasBomb &&
          openedSquares[((i + 1) * columnCount) + j] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i + 1, j);
        }
      }
    }

    setState(() {});
  }

  void _handleGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('You stepped on a mine!'),
          actions: [
            TextButton(
              onPressed: () {
                initializeGame(bombProbability, maxProbability);
                Navigator.pop(context);
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _handleWin() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Congratulations'),
          content: const Text('Huzzah! You swept the mines and lived!'),
          actions: [
            TextButton(
              onPressed: () {
                initializeGame(bombProbability, maxProbability);
                Navigator.pop(context);
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  Image getImage(ImageType type) {
    switch (type) {
      case ImageType.zero:
        return Image.asset('assets/images/minesweeper/0.png');
      case ImageType.one:
        return Image.asset('assets/images/minesweeper/1.png');
      case ImageType.two:
        return Image.asset('assets/images/minesweeper/2.png');
      case ImageType.three:
        return Image.asset('assets/images/minesweeper/3.png');
      case ImageType.four:
        return Image.asset('assets/images/minesweeper/4.png');
      case ImageType.five:
        return Image.asset('assets/images/minesweeper/5.png');
      case ImageType.six:
        return Image.asset('assets/images/minesweeper/6.png');
      case ImageType.seven:
        return Image.asset('assets/images/minesweeper/7.png');
      case ImageType.eight:
        return Image.asset('assets/images/minesweeper/8.png');
      case ImageType.bomb:
        return Image.asset('assets/images/minesweeper/bomb.png');
      case ImageType.facingDown:
        return Image.asset('assets/images/minesweeper/facingDown.png');
      case ImageType.flagged:
        return Image.asset('assets/images/minesweeper/flagged.png');

      default:
        return Image.asset('assets/images/minesweeper/facingDown.png');
    }
  }

  ImageType getImageTypeFromNumber(int number) {
    switch (number) {
      case 0:
        return ImageType.zero;
      case 1:
        return ImageType.one;
      case 2:
        return ImageType.two;
      case 3:
        return ImageType.three;
      case 4:
        return ImageType.four;
      case 5:
        return ImageType.five;
      case 6:
        return ImageType.six;
      case 7:
        return ImageType.seven;
      case 8:
        return ImageType.eight;

      default:
        return ImageType.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Container(
            color: Colors.grey,
            height: headerHeight,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    initializeGame(bombProbability, maxProbability);
                  },
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.tag_faces,
                      color: Colors.black,
                      size: 40,
                    ),
                    backgroundColor: Colors.yellowAccent,
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
            ),
            itemCount: rowCount * columnCount,
            itemBuilder: (context, position) {
              int rowNumber = (position / columnCount).floor();
              int columnNumber = (position % columnCount);

              Image image;

              if (openedSquares[position] == false) {
                if (flaggedSquares[position] == true) {
                  image = getImage(ImageType.flagged);
                } else {
                  image = getImage(ImageType.facingDown);
                }
              } else {
                if (board[rowNumber][columnNumber].hasBomb) {
                  image = getImage(ImageType.bomb);
                } else {
                  image = getImage(
                    getImageTypeFromNumber(
                      board[rowNumber][columnNumber].bombsAround,
                    ),
                  );
                }
              }

              return InkWell(
                // Opens squares
                onTap: () {
                  if (board[rowNumber][columnNumber].hasBomb) {
                    _handleGameOver();
                  }
                  if (board[rowNumber][columnNumber].bombsAround == 0) {
                    _handleTap(rowNumber, columnNumber);
                  } else {
                    setState(() {
                      openedSquares[position] = true;
                      squaresLeft = squaresLeft - 1;
                    });
                  }

                  if (squaresLeft <= bombCount) {
                    _handleWin();
                  }
                },
                onLongPress: () {
                  if (openedSquares[position] == false) {
                    setState(() {
                      flaggedSquares[position] = true;
                    });
                  }
                },
                splashColor: Colors.grey,
                child: Container(
                  color: Colors.grey,
                  child: image,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
