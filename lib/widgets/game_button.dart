import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class GameButton extends StatefulWidget {
  const GameButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function() onPress;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationTween;
  bool waitForAnim = true;
  bool isFading = false;
  bool isRaising = false;
  bool isPressed = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationTween = Tween(begin: 0.0, end: 4.0).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });

    Timer(
      const Duration(milliseconds: 200),
      () {
        setState(() {
          isFading = true;
        });
      },
    );
    Timer(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          isRaising = true;
        });
        _animationController.forward();
      },
    );
    Timer(
      const Duration(milliseconds: 1000),
      () {
        setState(() {
          isRaising = false;
          waitForAnim = false;
        });
        // _animationController.forward();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTapDown: (details) => {
        setState(() {
          isPressed = true;
        }),
      },
      onTapCancel: () => {
        setState(() {
          isPressed = false;
        }),
      },
      child: AnimatedOpacity(
        opacity: isFading ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        child: NeumorphicButton(
          style: NeumorphicStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            depth: waitForAnim
                ? _animationTween.value
                : isPressed
                    ? -4
                    : 4,
            intensity: 2.5,
            shadowDarkColor:
                Theme.of(context).colorScheme.surface.withOpacity(0.575),
            shadowDarkColorEmboss:
                Theme.of(context).colorScheme.surface.withOpacity(0.575),
            shadowLightColor:
                Theme.of(context).colorScheme.background.withOpacity(1),
            shadowLightColorEmboss:
                Theme.of(context).colorScheme.background.withOpacity(1),
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          ),
          onPressed: () {
            Timer(
              const Duration(milliseconds: 200),
              () => widget.onPress(),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                widget.icon,
                size: 0.1 * height,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 0.01875 * height,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
