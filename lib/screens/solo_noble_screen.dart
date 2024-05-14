import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

typedef SoloNobleBuilder = void Function(
  BuildContext context,
  void Function() resetBoard,
);

class SoloNobleScreen extends StatefulWidget {
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
      screen: 'Solo Noble',
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
      flactionButton: FloatingActionButton(
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
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      infoTitle: 'Solo Noble',
      infoDetails:
          'Remove pegs by jumping them with other pegs. Try to get your last peg to end up in the center.',
      screenFunction: (_) {},
      child: SoloNobleBoard(
        builder: (context, void Function() resetGame) {
          resetSoloNoble = resetGame;
        },
      ),
    );
  }
}
