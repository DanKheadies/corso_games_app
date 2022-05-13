import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/timer/timer_bloc.dart';
// import 'package:corso_games_app/models/ticker.dart';
import 'package:corso_games_app/widgets/dino_dash/cactus.dart';
import 'package:corso_games_app/widgets/dino_dash/cloud.dart';
import 'package:corso_games_app/widgets/dino_dash/constants.dart';
import 'package:corso_games_app/widgets/dino_dash/dino.dart';
import 'package:corso_games_app/widgets/dino_dash/game_object.dart';
import 'package:corso_games_app/widgets/dino_dash/ground.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class DinoRunScreen extends StatefulWidget {
  static const String id = 'dino-dash';

  const DinoRunScreen({Key? key}) : super(key: key);

  @override
  State<DinoRunScreen> createState() => _DinoRunScreenState();
}

class _DinoRunScreenState extends State<DinoRunScreen>
    with SingleTickerProviderStateMixin {
  Dino dino = Dino();
  double deathCounter = 0;
  double runDistance = 0;
  double runVelocity = 30;
  Duration elapsedTime = const Duration();

  late AnimationController worldController;
  Duration lastUpdateCall = const Duration();

  List<Cactus> cacti = initCacti;
  List<Cloud> clouds = initClouds;
  List<Ground> ground = initGround;

  @override
  void initState() {
    super.initState();
    worldController = AnimationController(
      vsync: this,
      duration: const Duration(
        days: 99,
      ),
    );
    worldController.addListener(_update);
    worldController.forward();
  }

  void _die() {
    setState(() {
      worldController.stop();
      dino.die();
    });
  }

  _update() {
    // print(worldController.lastElapsedDuration);
    if (worldController.lastElapsedDuration == null) return;
    // print('not null');
    dino.update(
        lastUpdateCall, worldController.lastElapsedDuration as Duration);

    double elapsedTimeSeconds =
        (worldController.lastElapsedDuration! - lastUpdateCall).inMilliseconds /
            1000;

    runDistance += runVelocity * elapsedTimeSeconds;

    Size screenSize = MediaQuery.of(context).size;

    // DC: DinoRect isn't the best against CactiRect as a hitbox & couldn't get RoundedRect to work;
    // Using a counter to see how "long" the dino is colliding to trigger death
    Rect dinoRect = dino.getRect(screenSize, runDistance);

    for (Cactus cactus in cacti) {
      Rect obstacleRect = cactus.getRect(screenSize, runDistance);

      if (dinoRect.overlaps(obstacleRect)) {
        setState(() {
          deathCounter++;
        });

        if (deathCounter > 7) {
          _die();
        }
      }

      if (obstacleRect.right < 0) {
        setState(() {
          cacti.remove(cactus);
          cacti.add(
            Cactus(
              worldLocation:
                  Offset(runDistance + Random().nextInt(100) + 50, 0),
            ),
          );
        });
        deathCounter = 0;
      }
    }

    for (Ground groundlet in ground) {
      if (groundlet.getRect(screenSize, runDistance).right < 0) {
        setState(() {
          ground.remove(groundlet);
          ground.add(
            Ground(
              worldLocation: Offset(
                  ground.last.worldLocation.dx + groundSprite.imageWidth / 10,
                  0),
            ),
          );
        });
      }
    }

    for (Cloud cloud in clouds) {
      if (cloud.getRect(screenSize, runDistance).right < 0) {
        setState(() {
          clouds.remove(cloud);
          clouds.add(
            Cloud(
              worldLocation: Offset(
                  clouds.last.worldLocation.dx + Random().nextInt(100) + 50,
                  Random().nextInt(40) - 20.0),
            ),
          );
        });
      }
    }

    if (dino.isDead) return;
    lastUpdateCall = worldController.lastElapsedDuration as Duration;
  }

  void reset() {
    dino.reset();

    setState(() {
      deathCounter = 0;
    });

    cacti = initCacti;
    clouds = initClouds;
    ground = initGround;

    worldController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    worldController.removeListener(_update);
    worldController.dispose();
  }

  void restartTimer(BuildContext context) {
    context.read<TimerBloc>().add(TimerReset());
  }

  void startTimer(BuildContext context, TimerState state) {
    context.read<TimerBloc>().add(TimerStarted(duration: state.duration));
  }

  void stopTimer(BuildContext context) {
    context.read<TimerBloc>().add(const TimerPaused());
  }

  BlocBuilder actionButtons(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        // context.read<TimerBloc>().add(TimerStarted(duration: state.duration));
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // children: const [],
          children: [
            if (state is TimerReady) ...[
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () => context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.duration)),
              ),
            ] else if (state is TimerRunning) ...[
              FloatingActionButton(
                child: const Icon(Icons.pause),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerPaused()),
              ),
              FloatingActionButton(
                child: const Icon(Icons.refresh),
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
              ),
            ] else if (state is TimerStopped) ...[
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () => context
                    .read<TimerBloc>()
                    .add(TimerResumed(duration: state.duration)),
              ),
              FloatingActionButton(
                child: const Icon(Icons.refresh),
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
              ),
              // ] else if (state is TimerComplete) ...[
              //   FloatingActionButton(
              //     child: const Icon(Icons.refresh),
              //     onPressed: () => context.read<TimerBloc>().add(TimerReset()),
              //   ),
            ],
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Widget> children = [];

    for (GameObject object in [
      ...clouds,
      ...ground,
      ...cacti,
      dino,
    ]) {
      children.add(
        AnimatedBuilder(
          animation: worldController,
          builder: (context, _) {
            Rect objectRect = object.getRect(screenSize, runDistance);
            return Positioned(
              left: objectRect.left,
              top: objectRect.top,
              width: objectRect.width,
              height: objectRect.height,
              child: object.render(),
            );
          },
        ),
      );
    }

    children.add(
      Positioned(
        top: 20,
        right: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${context.select((TimerBloc bloc) => bloc.state.duration)}',
              style: Theme.of(context).textTheme.headline3,
            ),
            // actionButtons(context),
            // Text('${context.select((TimerBloc bloc) => bloc.state)}'),
          ],
        ),
      ),
    );

    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        if (dino.isDead) {
          stopTimer(context);
        } else if (!dino.isDead && state.duration > 0 && runDistance == 0) {
          print('derp');
          restartTimer(context);
        } else if (!dino.isDead && state.duration < 1) {
          startTimer(context, state);
        }
        return ScreenWrapper(
          title: 'Dino Dash',
          infoTitle: 'Dino Dash',
          infoDetails: 'Good luck, have fun!',
          backgroundOverride: Colors.transparent,
          content: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => dino.jump(),
            child: Stack(
              alignment: Alignment.center,
              children: children,
            ),
          ),
          screenFunction: (String _string) {
            if (_string == 'drawerOpen') {
              stopTimer(context);
              worldController.stop();
            } else if (_string == 'drawerClose') {
              startTimer(context, state);
              worldController.repeat();
              // worldController.forward();
              // worldController.forward(from: state.duration.toDouble());
            }
          },
          bottomBar: BottomAppBar(
            color: Theme.of(context).colorScheme.tertiary,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  tooltip: 'Settings',
                  icon: Icon(
                    Icons.settings,
                    // color: Colors.white,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  tooltip: 'Share',
                  icon: Icon(
                    Icons.ios_share_outlined,
                    // color: Colors.white,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          floatingButton: FloatingActionButton(
            onPressed: () {
              restartTimer(context);
              reset();
            },
            tooltip: 'Reset',
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: IconButton(
              icon: const Icon(
                Icons.settings_backup_restore_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                restartTimer(context);
                reset();
              },
            ),
          ),
          floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
