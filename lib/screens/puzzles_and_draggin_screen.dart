import 'dart:async';

import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PuzzlesAndDragginScreen extends StatefulWidget {
  const PuzzlesAndDragginScreen({super.key});

  @override
  State<PuzzlesAndDragginScreen> createState() =>
      _PuzzlesAndDragginScreenState();
}

class _PuzzlesAndDragginScreenState extends State<PuzzlesAndDragginScreen> {
  bool resetGrid = false;
  double topPad = 50;
  double bottPad = 30;
  double boardPad = 0; // 4 for 5; 3 for 6
  int squaresPerRow = 6;
  int challenge = 0;
  int currentTurn = 0;
  List<int> roundWon = [0, 0, 0, 0, 0, 0, 0, 0];
  List<int> roundLimit = [0, 0, 0, 1, 3, 2, 0, 3];
  List<String> instruction = [
    'Move the green dot to the bottom right.',
    'Move the green dots into the 4 corners.',
    'Move the green dots to the center line.',
    'Move the green dot to the bottom right in 1 turn.',
    'Move the green dots into the 4 corners in 3 turns.',
    'Move the green dots to the center line in 2 turns.',
    'Form a green rectangle at the center.',
    'Form a green rectangle at the center in 3 turns.'
  ];

  @override
  void initState() {
    super.initState();
  }

  void turnTicker() {
    // Stop ticking when challenge is won.
    if (roundWon[challenge] != 1) {
      setState(() {
        currentTurn += 1;
      });
    }
  }

  void wonRound() {
    if (roundLimit[challenge] == 0) {
      setState(() {
        roundWon[challenge] = 1;
      });
    } else if (currentTurn <= roundLimit[challenge]) {
      setState(() {
        roundWon[challenge] = 1;
      });
    }
  }

  void resetGameBoard() {
    setState(() {
      currentTurn = 0;
      resetGrid = true;
    });
  }

  void unsetReset() {
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        resetGrid = false;
      });
    });
  }

  Widget _buildGameGrid(
    int chal,
    double width,
    double size,
    bool reset,
  ) {
    if (reset) {
      setState(() {
        resetGrid = false;
      });

      if (chal == 0 || chal == 3) {
        return GameGrid0(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
          resetGameBoard: reset,
          unsetReset: unsetReset,
          turnsTicker: turnTicker,
          roundWon: wonRound,
        );
      } else if (chal == 1 || chal == 4) {
        return GameGrid1(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
          resetGameBoard: reset,
          unsetReset: unsetReset,
          turnsTicker: turnTicker,
          roundWon: wonRound,
        );
      } else if (chal == 2 || chal == 5) {
        return GameGrid2(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
          resetGameBoard: reset,
          unsetReset: unsetReset,
          turnsTicker: turnTicker,
          roundWon: wonRound,
        );
      } else if (chal == 6 || chal == 7) {
        return GameGrid3(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
          resetGameBoard: reset,
          unsetReset: unsetReset,
          turnsTicker: turnTicker,
          roundWon: wonRound,
        );
      } else {
        return GameGrid(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
        );
      }
    } else {
      if (chal == 0 || chal == 3) {
        return GameGrid0(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
          resetGameBoard: reset,
          unsetReset: unsetReset,
          turnsTicker: turnTicker,
          roundWon: wonRound,
        );
      } else if (chal == 1 || chal == 4) {
        return GameGrid1(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
          resetGameBoard: reset,
          unsetReset: unsetReset,
          turnsTicker: turnTicker,
          roundWon: wonRound,
        );
      } else if (chal == 2 || chal == 5) {
        return GameGrid2(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
          resetGameBoard: reset,
          unsetReset: unsetReset,
          turnsTicker: turnTicker,
          roundWon: wonRound,
        );
      } else if (chal == 6 || chal == 7) {
        return GameGrid3(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
          resetGameBoard: reset,
          unsetReset: unsetReset,
          turnsTicker: turnTicker,
          roundWon: wonRound,
        );
      } else {
        return GameGrid(
          boardPad: boardPad,
          gridWidth: width,
          squareSize: size,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmall =
        Responsive.isMobile(context) || Responsive.isTablet(context);
    final double width = MediaQuery.of(context).size.width;
    final double screenWidth = isSmall ? width : 750;
    final double squareSize = (screenWidth - boardPad * 2) /
        (squaresPerRow * 1); // for 6 squares w/out padding

    return ScreenWrapper(
      screen: 'Puzzles & Draggin',
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Settings',
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Share',
              icon: Icon(
                Icons.ios_share_outlined,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      button: 'Leggooo!',
      flactionButton: FloatingActionButton(
        onPressed: resetGameBoard,
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(
            Icons.settings_backup_restore_rounded,
            color: Theme.of(context).colorScheme.background,
            size: 30,
          ),
          onPressed: resetGameBoard,
        ),
      ),
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      infoTitle: 'Puzzles And Draggin',
      infoDetails:
          'Drag the circles. Use the force. Follow the instructions. Use the circle you\'re dragging to move other circles.',
      screenFunction: (_) {},
      child: Padding(
        padding: EdgeInsets.only(
          top: isSmall ? topPad : 10,
          bottom: isSmall ? bottPad : 5,
          left: isSmall ? 0 : (width - 800) / 2,
          right: isSmall ? 0 : (width - 800) / 2,
        ),
        child: Column(
          children: [
            Expanded(
              // flex: 10,
              flex: Responsive.isMobile(context) ? 10 : 5,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Turns'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$currentTurn',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                        ),
                        const SizedBox(width: 5),
                        const Text('/'),
                        const SizedBox(width: 5),
                        (challenge == 3 ||
                                challenge == 4 ||
                                challenge == 5 ||
                                challenge == 7)
                            ? Text(
                                '${roundLimit[challenge]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                              )
                            : FaIcon(
                                FontAwesomeIcons.infinity,
                                // color: Colors.black,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                      ],
                    ),
                    SizedBox(height: isSmall ? 25 : 10),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        instruction[challenge],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    roundWon[challenge] == 1
                        ? challenge >= 7
                            ? const SizedBox(
                                height: 48,
                                child: Center(
                                  child: Text('Thanks for playing!'),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    challenge += 1;
                                    currentTurn = 0;
                                    resetGrid = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  // backgroundColor: Colors.black,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                child: Text(
                                  'Huzzah! Next Challenge',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              )
                        : currentTurn >= roundLimit[challenge] &&
                                roundLimit[challenge] != 0
                            ? ElevatedButton(
                                onPressed: resetGameBoard,
                                style: ElevatedButton.styleFrom(
                                  // backgroundColor: Colors.black,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                child: Text(
                                  'Try again!',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                              )
                            : const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
            Expanded(
              // flex: 15,
              flex: Responsive.isMobile(context) ? 15 : 18,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                // color: Colors.white,
                child: _buildGameGrid(
                  challenge,
                  screenWidth,
                  squareSize,
                  resetGrid,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
