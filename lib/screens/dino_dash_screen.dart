import 'dart:math';

import 'package:flutter/material.dart';

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

        if (deathCounter > 5) {
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

    return ScreenWrapper(
      title: 'Dino Dash',
      infoTitle: 'Dino Dash',
      infoDetails: 'Good luck, have fun!',
      backgroundOverride: Colors.transparent,
      content: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dino.jump();
        },
        child: Stack(
          alignment: Alignment.center,
          children: children,
        ),
      ),
      screenFunction: (String _string) {
        if (_string == 'drawerOpen') {
          // TODO: Handle pausing; probably tied up with timer / score
          // print('pausing');
          // print(lastUpdateCall);
          // setState(() {
          //   elapsedTime = lastUpdateCall;
          // });
          worldController.stop();
        } else if (_string == 'drawerClose') {
          // print('unpause');
          // print(elapsedTime);
          // print(elapsedTime.inSeconds);
          // worldController.forward(from: 2);
          worldController.forward();
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
        onPressed: () {},
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          icon: const Icon(
            Icons.settings_backup_restore_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: reset,
        ),
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
