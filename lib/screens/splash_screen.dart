import 'dart:async';

import 'package:flutter/material.dart';

import 'package:corso_games_app/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  // static const String id = 'splash';
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SplashScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController controller;
  late final Timer timer;

  @override
  void initState() {
    super.initState();

    setState(() {
      controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..repeat(reverse: true);

      animation = CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      );
    });

    timer = Timer(
      const Duration(seconds: 4),
      () => Navigator.pushNamed(
        context,
        GamesScreen.routeName,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: InkWell(
        onTap: () {
          timer.cancel();
          Navigator.pushNamed(
            context,
            GamesScreen.routeName,
          );
        },
        child: Center(
          child: ScaleTransition(
            scale: animation,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: MediaQuery.of(context).platformBrightness ==
                        Brightness.dark
                    ? const AssetImage('assets/images/main/corso-games-2.png')
                    : const AssetImage('assets/images/main/corso-games-1.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
