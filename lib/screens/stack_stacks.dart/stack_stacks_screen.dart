import 'package:corso_games_app/providers/providers.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StackStacksScreen extends StatelessWidget {
  const StackStacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double gameAreaHeight =
        MediaQuery.of(context).size.height - // Screen height
            MediaQuery.of(context).padding.top - // AppBar height
            45; // BottomAppBar height

    return ChangeNotifierProvider(
      create: (context) => StackStacksProvider(),
      child: Consumer<StackStacksProvider>(
        builder: (context, stacksProvider, child) {
          List<StacksStackWidget> stacksStackWidgets =
              stacksProvider.createBrickStackWidgetList(
            context,
            gameAreaHeight,
          );

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
                children: [],
              ),
            ),
            flactionButton: FloatingActionButton(
              // onPressed: () => context.read<StackStacksProvider>().resetGame(),
              onPressed: () => stacksProvider.resetGame(),
              tooltip: 'Reset',
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: const CircleBorder(),
              child: IconButton(
                icon: Icon(
                  Icons.settings_backup_restore_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 30,
                ),
                // onPressed: () => context.read<StackStacksProvider>().resetGame(),
                onPressed: () => stacksProvider.resetGame(),
              ),
            ),
            flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
            infoTitle: 'Stacks on Stacks',
            infoDetails: 'Move the colored bricks into the same stack.',
            screenFunction: (_) {},
            child: Center(
              child: StackStacksGame(
                stacksStackWidgets: stacksStackWidgets,
              ),
            ),
          );
        },
      ),
    );
  }
}
