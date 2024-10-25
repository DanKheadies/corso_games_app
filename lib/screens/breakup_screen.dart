import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BreakupScreen extends StatefulWidget {
  const BreakupScreen({super.key});

  @override
  State<BreakupScreen> createState() => _BreakupScreenState();
}

class _BreakupScreenState extends State<BreakupScreen> {
  bool hasLeft = false;
  bool pauseGame = false;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Breakup',
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // BlocBuilder<BallBounceCubit, BallBounceState>(
            //   builder: (context, state) {
            //     return TextButton(
            //       child: Text(
            //         state.score.toString(),
            //         style: TextStyle(
            //           color: Theme.of(context).colorScheme.onSurface,
            //           fontSize: 24,
            //         ),
            //       ),
            //       onPressed: () {
            //       },
            //     );
            //   },
            // ),
            // const SizedBox(width: 24),
            // // TODO: reset throws an error
            // IconButton(
            //   icon: Icon(
            //     Icons.settings_backup_restore_rounded,
            //     color: Theme.of(context).colorScheme.onSurface,
            //     size: 30,
            //   ),
            //   onPressed: () {
            //     BreakupWorld().reset();
            //   },
            // ),
            // const SizedBox(width: 24),
          ],
        ),
      ),
      // flactionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increase Speed',
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   shape: const CircleBorder(),
      //   child: IconButton(
      //     tooltip: 'Increase Speed',
      //     icon: Icon(
      //       Icons.bolt,
      //       color: Theme.of(context).colorScheme.onSurface,
      //       size: 30,
      //     ),
      //     onPressed: () {},
      //   ),
      // ),
      // flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      infoTitle: 'Ball Bounce',
      infoDetails:
          'Ball the ball against the blocks. Don\'t let them reach the bottom of the screen.',
      screenFunction: (String string) {
        if (string == 'drawerOpen') {
          setState(() {
            pauseGame = true;
          });
        } else if (string == 'drawerClose') {
          if (!hasLeft) {
            setState(() {
              pauseGame = false;
            });
          }
        } else if (string == 'drawerNavigate') {
          setState(() {
            hasLeft = true;
          });
        }
      },
      // child: const GameWidget.controlled(
      //   gameFactory: BreakupGame.new,
      // ),
      // child: GameWidget.controlled(
      //   gameFactory: BreakupGame.new,
      //   overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
      //       'gameOverOverlay': (context, game) => BallBounceOver(
      //             game: game,
      //           ),
      //       'gamePauseOverlay': (context, game) => BallBouncePause(
      //             game: game,
      //           ),
      //     },
      // ),
      // TODO: this option refreshes the entire game when the context (theme) updates
      child: GameWidget(
        game: BreakupGame(context: context),
        backgroundBuilder: (context) => Container(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
