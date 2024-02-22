import 'package:flutter/material.dart';

import 'package:corso_games_app/widgets/widgets.dart';

typedef SoloNobleBuilder = void Function(
  BuildContext context,
  void Function() resetBoard,
);

class SoloNobleScreen extends StatefulWidget {
  static const String routeName = '/solo-noble';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SoloNobleScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SoloNobleScreen({super.key});

  @override
  State<SoloNobleScreen> createState() => _SoloNobleScreenState();
}

class _SoloNobleScreenState extends State<SoloNobleScreen> {
  // SoloNobleBoard board = SoloNobleBoard();

  late void Function() resetSoloNoble;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Solo Noble',
      infoTitle: 'Solo Noble',
      infoDetails:
          'Remove pegs by jumping them with other pegs. Try to get your last peg to end up in the center.',
      backgroundOverride: Colors.transparent,
      content: SoloNobleBoard(
        builder: (context, void Function() resetGame) {
          resetSoloNoble = resetGame;
        },
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
      floatingButton: FloatingActionButton(
        // onPressed: resetGameBoard,
        onPressed: () => resetSoloNoble.call(),
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(
            Icons.settings_backup_restore_rounded,
            color: Theme.of(context).colorScheme.background,
            size: 30,
          ),
          onPressed: () => resetSoloNoble.call(),
        ),
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
