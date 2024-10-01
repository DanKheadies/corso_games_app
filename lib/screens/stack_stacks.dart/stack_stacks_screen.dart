import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StackStacksScreen extends StatelessWidget {
  const StackStacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Stacks on Stacks',
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // IconButton(
            //   tooltip: 'Settings',
            //   icon: Icon(
            //     Icons.settings,
            //     color: Theme.of(context).colorScheme.secondary,
            //     size: 30,
            //   ),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   tooltip: 'Share',
            //   icon: Icon(
            //     Icons.ios_share_outlined,
            //     color: Theme.of(context).colorScheme.secondary,
            //     size: 30,
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
      // flactionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   tooltip: 'Reset',
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   shape: const CircleBorder(),
      //   child: IconButton(
      //     icon: Icon(
      //       Icons.settings_backup_restore_rounded,
      //       color: Theme.of(context).colorScheme.onSurface,
      //       size: 30,
      //     ),
      //     onPressed: () => {},
      //   ),
      // ),
      // flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      infoTitle: 'Stacks on Stacks',
      infoDetails: 'Move the colored bricks into the same stack.',
      screenFunction: (_) {},
      child: const Center(
        child: StackStacksGame(),
      ),
    );
  }
}
