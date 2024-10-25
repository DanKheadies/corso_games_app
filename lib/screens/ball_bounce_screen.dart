import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BallBounceScreen extends StatefulWidget {
  const BallBounceScreen({super.key});

  @override
  State<BallBounceScreen> createState() => _BallBounceScreenState();
}

class _BallBounceScreenState extends State<BallBounceScreen> {
  bool hasLeft = false;
  bool pauseGame = false;

  late Game game;

  @override
  void initState() {
    super.initState();

    game = BallBounceGame(context: context);
  }

  void test(BuildContext context) {
    print('test');
    game = BallBounceGame(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Ball Bounce',
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<BallBounceCubit, BallBounceState>(
              builder: (context, state) {
                return TextButton(
                  child: Text(
                    state.score.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                    ),
                  ),
                  onPressed: () {
                    (game as BallBounceGame).togglePauseState();
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings_backup_restore_rounded,
                color: Theme.of(context).colorScheme.onSurface,
                size: 30,
              ),
              onPressed: () {
                (game as BallBounceGame).resetGame(context);
                // test(context);
              },
            ),
          ],
        ),
      ),
      flactionButton: FloatingActionButton(
        onPressed: () {
          (game as BallBounceGame).increaseBallSpeed();
        },
        tooltip: 'Increase Speed',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: IconButton(
          tooltip: 'Increase Speed',
          icon: Icon(
            Icons.bolt,
            color: Theme.of(context).colorScheme.onSurface,
            size: 30,
          ),
          onPressed: () {
            (game as BallBounceGame).increaseBallSpeed();
          },
        ),
      ),
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.info_outline,
          ),
          onPressed: () => showScreenInfo(
            context,
            'Ball Bounce',
            'Shoot the ball against the blocks and see how many rounds you can survive. Don\'t let the blocks reach the bottom of the screen. Hit the bolt button to speed up the ball.',
            false,
            TextAlign.left,
            'GLHF',
          ),
        ),
        BlocBuilder<BrightnessCubit, Brightness>(
          builder: (context, state) {
            return IconButton(
                icon: Icon(
                  state == Brightness.dark ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () async {
                  context.read<BrightnessCubit>().toggleBrightness();
                  await Future.delayed(const Duration(milliseconds: 300));
                  var newReset = (game as BallBounceGame).resetGame(context);
                  // TODO: needs this context afterwards to work right, but this isn't right..
                  newReset;
                });
          },
        ),
        const SizedBox(width: 10),
      ],
      infoTitle: 'Ball Bounce',
      infoDetails:
          'Shoot the ball against the blocks and see how many rounds you can survive. Don\'t let the blocks reach the bottom of the screen. Hit the bolt button to speed up the ball.',
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
          context.read<BallBounceCubit>().setScore(0);

          setState(() {
            hasLeft = true;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: GameWidget(
          game: game,
          // game: BallBounceGame(
          //   context: context,
          // ),
          backgroundBuilder: (context) => Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
            'gameOverOverlay': (context, game) => BallBounceOver(
                  game: game,
                ),
            'gamePauseOverlay': (context, game) => BallBouncePause(
                  game: game,
                ),
          },
        ),
      ),
    );
  }
}
