import 'dart:math';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DinoDashScreen extends StatefulWidget {
  const DinoDashScreen({super.key});

  @override
  State<DinoDashScreen> createState() => _DinoDashScreenState();
}

class _DinoDashScreenState extends State<DinoDashScreen>
    with SingleTickerProviderStateMixin {
  bool hasLeft = false;
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
    if (worldController.lastElapsedDuration == null) return;
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

  // @override
  // void didChangeDependencies() {
  //   print('did');
  //   hasLeft = true;
  //   super.didChangeDependencies();
  // }

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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );

    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        if (dino.isDead) {
          stopTimer(context);
        } else if (!dino.isDead && state.duration > 0 && runDistance == 0) {
          restartTimer(context);
        } else if (!dino.isDead && state.duration < 1) {
          startTimer(context, state);
        }
        return ScreenWrapper(
          screen: 'Dino Dash',
          bottomBar: BottomAppBar(
            color: Theme.of(context).colorScheme.secondary,
            elevation: 0,
            height: 45,
            padding: EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),
            child: const SizedBox(),
          ),
          flactionButton: FloatingActionButton(
            onPressed: () {
              restartTimer(context);
              reset();
            },
            tooltip: 'Reset',
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: const CircleBorder(),
            child: IconButton(
              icon: Icon(
                Icons.settings_backup_restore_rounded,
                color: Theme.of(context).colorScheme.onSurface,
                size: 30,
              ),
              onPressed: () {
                restartTimer(context);
                reset();
              },
            ),
          ),
          flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
          infoTitle: 'Dino Dash',
          infoDetails:
              'Run for your life! If you die, you may come back. Or go to Heaven. Or to Hell.. Or the mantle?.. Don\'t die!',
          screenFunction: (String string) {
            // if (!hasLeft) {
            //   if (string == 'drawerOpen') {
            //     stopTimer(context);
            //     worldController.stop();
            //   } else if (string == 'drawerClose') {
            //     startTimer(context, state);
            //     worldController.repeat();
            //   }
            // }
            if (string == 'drawerOpen') {
              print(hasLeft);
              stopTimer(context);
              worldController.stop();
            } else if (string == 'drawerClose') {
              print(hasLeft);
              if (!hasLeft) {
                startTimer(context, state);
                worldController.repeat();
              }
            } else if (string == 'drawerNavigate') {
              // print('nav');
              setState(() {
                hasLeft = true;
              });
            }
          },
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => dino.jump(),
            child: Stack(
              alignment: Alignment.center,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
