import 'dart:async';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
      () => context.goNamed('welcome'),
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
          context.goNamed('welcome');
        },
        child: Center(
          child: ScaleTransition(
            scale: animation,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<BrightnessCubit, Brightness>(
                builder: (context, state) {
                  return Image(
                    image: state == Brightness.dark
                        ? const AssetImage(
                            'assets/images/main/corso-games-2.png')
                        : const AssetImage(
                            'assets/images/main/corso-games-1.png'),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
