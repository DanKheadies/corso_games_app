import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/minesweeper/mine_board_square.dart';
import 'package:corso_games_app/screens/minesweeper/ms_settings_screen.dart';
import 'package:corso_games_app/widgets/minesweeper/ms_timer.dart';

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

class MinesweeperGame extends StatefulWidget {
  const MinesweeperGame({
    Key? key,
    required this.resetMinesweeper,
    required this.showMineTimer,
    required this.mineDifficulty,
    required this.mineTimerSeconds,
    required this.bombProbability,
    required this.maxProbability,
    required this.bombCount,
    required this.squaresLeft,
    required this.board,
    required this.openedSquares,
    required this.flaggedSquares,
  }) : super(key: key);

  final bool resetMinesweeper;
  final bool showMineTimer;
  final MinesweeperDifficulty mineDifficulty;
  final int mineTimerSeconds;
  final int bombProbability;
  final int maxProbability;
  final int bombCount;
  final int squaresLeft;
  final List<List<MineBoardSquare>> board;
  final List<bool> openedSquares;
  final List<bool> flaggedSquares;

  @override
  State<MinesweeperGame> createState() => _MinesweeperGameState();
}

class _MinesweeperGameState extends State<MinesweeperGame> {
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
  // static int initBombProbability = 3;
  // static int initMaxProbability = 30;
  // int bombProbability = initBombProbability;
  // int maxProbability = initMaxProbability;
  int bombProbability = 3;
  int maxProbability = 30;

  int bombCount = 0;
  int squaresLeft = 0;

  List<List<MineBoardSquare>> board = [];
  List<bool> openedSquares = [];
  List<bool> flaggedSquares = [];

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    if (widget.mineDifficulty == MinesweeperDifficulty.easy) {
      bombProbability = 3;
      maxProbability = 30;
    } else if (widget.mineDifficulty == MinesweeperDifficulty.medium) {
      bombProbability = 3;
      maxProbability = 20;
    } else if (widget.mineDifficulty == MinesweeperDifficulty.hard) {
      bombProbability = 3;
      maxProbability = 15;
    } else if (widget.mineDifficulty == MinesweeperDifficulty.harder) {
      bombProbability = 5;
      maxProbability = 20;
    } else if (widget.mineDifficulty == MinesweeperDifficulty.wtf) {
      bombProbability = 5;
      maxProbability = 15;
    }

    board = List.generate(rowCount, (i) {
      return List.generate(columnCount, (j) {
        return MineBoardSquare();
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
    // TODO: set the bloc state now
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
                // widget.timerReset();
                initializeGame();
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
                // widget.timerReset();
                context.read<MinesweeperBloc>().add(
                      ToggleMinesweeperReset(),
                    );
                initializeGame();
                Navigator.pop(context);
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  Image getImage(
    ImageType type,
    BuildContext context,
  ) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? true
            : false;
    switch (type) {
      case ImageType.zero:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_0.png'
            : 'assets/images/minesweeper/0.png');
      case ImageType.one:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_1.png'
            : 'assets/images/minesweeper/1.png');
      case ImageType.two:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_2.png'
            : 'assets/images/minesweeper/2.png');
      case ImageType.three:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_3.png'
            : 'assets/images/minesweeper/3.png');
      case ImageType.four:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_4.png'
            : 'assets/images/minesweeper/4.png');
      case ImageType.five:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_5.png'
            : 'assets/images/minesweeper/5.png');
      case ImageType.six:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_6.png'
            : 'assets/images/minesweeper/6.png');
      case ImageType.seven:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_7.png'
            : 'assets/images/minesweeper/7.png');
      case ImageType.eight:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_8.png'
            : 'assets/images/minesweeper/8.png');
      case ImageType.bomb:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_bomb.png'
            : 'assets/images/minesweeper/bomb.png');
      case ImageType.facingDown:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_facingDown.png'
            : 'assets/images/minesweeper/facingDown.png');
      case ImageType.flagged:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_flagged.png'
            : 'assets/images/minesweeper/flagged.png');

      default:
        return Image.asset(isDarkMode
            ? 'assets/images/minesweeper/_facingDown.png'
            : 'assets/images/minesweeper/facingDown.png');
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

  InkWell smilieReset() {
    return InkWell(
      onTap: () {
        // widget.timerReset();
        context.read<MinesweeperBloc>().add(
              ToggleMinesweeperReset(),
            );
        initializeGame();
      },
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(
          Icons.tag_faces,
          color: Theme.of(context).colorScheme.background,
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.resetGame) {
    //   initializeGame();
    // }
    if (widget.resetMinesweeper) {
      initializeGame();
      // context.read<ColorsSlideBloc>().add(
      //       ToggleColorsSlideReset(),
      //     );
    }

    return Center(
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: headerHeight,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                smilieReset(),
                if (widget.showMineTimer)
                  MSTimer(
                    timer: widget.showMineTimer,
                    mineTimerSeconds: widget.mineTimerSeconds,
                    // timerStatus: timerStatus,
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
                  image = getImage(ImageType.flagged, context);
                } else {
                  image = getImage(ImageType.facingDown, context);
                }
              } else {
                if (board[rowNumber][columnNumber].hasBomb) {
                  image = getImage(ImageType.bomb, context);
                } else {
                  image = getImage(
                    getImageTypeFromNumber(
                      board[rowNumber][columnNumber].bombsAround,
                    ),
                    context,
                  );
                }
              }

              return InkWell(
                // Opens squares
                onTap: () {
                  print('open');
                  if (board[rowNumber][columnNumber].hasBomb) {
                    print('gg');
                    _handleGameOver();
                  }
                  if (board[rowNumber][columnNumber].bombsAround == 0) {
                    print('bombs around');
                    _handleTap(rowNumber, columnNumber);
                  } else {
                    print('g2g');
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
                splashColor: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
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
