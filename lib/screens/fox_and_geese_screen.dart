import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

typedef FoxAndGeeseBuilder = void Function(
  BuildContext context,
  void Function() resetBoard,
);

class FoxAndGeeseScreen extends StatefulWidget {
  const FoxAndGeeseScreen({super.key});

  @override
  State<FoxAndGeeseScreen> createState() => _FoxAndGeeseScreenState();
}

class _FoxAndGeeseScreenState extends State<FoxAndGeeseScreen> {
  late void Function() resetFoxAndGeese;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Fox & Geese',
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
        onPressed: () => resetFoxAndGeese.call(),
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(
            Icons.settings_backup_restore_rounded,
            color: Theme.of(context).colorScheme.onSurface,
            size: 30,
          ),
          onPressed: () => resetFoxAndGeese.call(),
        ),
      ),
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      infoTitle: 'Fox & Geese',
      infoDetails:
          'You are a fox in a sea of geese. Move one space, in straight lines, in any direction. Jump a goose and take out out. Break the geese before they surround you.',
      screenFunction: (_) {},
      child: FoxAndGeeseBoard(
        builder: (context, void Function() resetGame) {
          resetFoxAndGeese = resetGame;
        },
      ),
    );
  }
}
