import 'dart:async';

import 'package:flutter/material.dart';

import './games_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer(
      const Duration(seconds: 4),
      () => Navigator.pushNamed(
        context,
        GamesScreen.id,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: InkWell(
        onTap: () {
          timer.cancel();
          Navigator.pushNamed(
            context,
            GamesScreen.id,
          );
        },
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/main/corso-games-1.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
