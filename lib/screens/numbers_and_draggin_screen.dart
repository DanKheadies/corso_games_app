import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:corso_games_app/widgets/widgets.dart';

class NumbersAndDragginScreen extends StatefulWidget {
  // static const String id = 'puzzles-and-draggin';
  static const String routeName = '/numbers-and-draggin';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const NumbersAndDragginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const NumbersAndDragginScreen({Key? key}) : super(key: key);

  @override
  State<NumbersAndDragginScreen> createState() =>
      _NumbersAndDragginScreenState();
}

class _NumbersAndDragginScreenState extends State<NumbersAndDragginScreen> {
  bool resetGrid = false;
  double boardPad = 0; // 4 for 5; 3 for 6
  int columns = 6;
  int rows = 5;

  void wonRound() {
    // print('won round');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Huzzah'),
          content: const Text('You did it!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  resetGrid = true;
                });
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No Thanks'),
            ),
          ],
        );
      },
    );
  }

  void resetGameBoard() {
    setState(() {
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
    double width,
    double size,
    bool reset,
  ) {
    if (reset) {
      setState(() {
        resetGrid = false;
      });
    }

    return NadGrid0(
      boardPad: boardPad,
      gridWidth: width,
      squareSize: size,
      columns: columns,
      rows: rows,
      resetGameBoard: reset,
      unsetReset: unsetReset,
      roundWon: wonRound,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double squareSize =
        (screenWidth - boardPad * 2) / columns; // for 6 squares w/out padding

    return ScreenWrapper(
      title: 'NAD',
      infoTitle: 'Numbers And Draggin',
      infoDetails:
          'Drag the green cricle to order the numbers from lowest to highest (left to right, then top down).',
      button: 'Leggooo!',
      backgroundOverride: Colors.transparent,
      content: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 6,
        ),
        child: Container(
          child: _buildGameGrid(
            screenWidth,
            squareSize,
            resetGrid,
          ),
        ),
      ),
      screenFunction: (String string) {},
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
                // color: Colors.white,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Share',
              icon: Icon(
                Icons.ios_share_outlined,
                // color: Colors.white,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingButton: FloatingActionButton(
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
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
