import 'dart:async';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class GameButton extends StatefulWidget {
  final bool? forHoneygram;
  final bool? isIconic;
  final Function()? onPress;
  final IconData icon;
  final String title;

  const GameButton({
    super.key,
    required this.icon,
    required this.onPress,
    required this.title,
    this.forHoneygram = false,
    this.isIconic = false,
  });

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
  late Timer timer1;
  late Timer timer2;
  late Timer timer3;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationTween = Tween(begin: 0.0, end: 4.0).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });

    timer1 = Timer(
      const Duration(milliseconds: 200),
      () {
        setState(() {
          isFading = true;
        });
      },
    );

    timer2 = Timer(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          isRaising = true;
        });
        _animationController.forward();
      },
    );
    timer3 = Timer(
      const Duration(milliseconds: 1000),
      () {
        setState(() {
          isRaising = false;
          waitForAnim = false;
        });
        // _animationController.forward();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    timer1.cancel();
    timer2.cancel();
    timer3.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
        child: BlocBuilder<BrightnessCubit, Brightness>(
          builder: (context, state) {
            return NeumorphicButton(
              style: NeumorphicStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                depth: waitForAnim
                    ? _animationTween.value
                    : isPressed
                        ? -4
                        : 4,
                intensity: 2.5,
                lightSource: state == Brightness.dark
                    ? LightSource.bottomRight
                    : LightSource.topLeft,
                shadowDarkColor:
                    Theme.of(context).colorScheme.surface.withOpacity(
                          state == Brightness.dark ? 0.275 : 0.5,
                        ),
                shadowDarkColorEmboss:
                    Theme.of(context).colorScheme.surface.withOpacity(
                          state == Brightness.dark ? 0.275 : 0.5,
                        ),
                shadowLightColor:
                    Theme.of(context).colorScheme.background.withOpacity(1),
                shadowLightColorEmboss:
                    Theme.of(context).colorScheme.background.withOpacity(1),
                shape: NeumorphicShape.flat,
                boxShape: widget.icon == Icons.arrow_back
                    ? const NeumorphicBoxShape.circle()
                    : NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(8),
                      ),
              ),
              onPressed: () {
                Timer(
                  const Duration(milliseconds: 200),
                  widget.onPress != null ? () => widget.onPress!() : () {},
                );
              },
              child: widget.forHoneygram!
                  ? SizedBox(
                      height: width / 6,
                      width: width / 6,
                      child: Icon(
                        widget.icon,
                        // size: 0.1 * height,
                        size: width / 10,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : widget.isIconic!
                      ? Column(
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
                        )
                      : widget.icon == Icons.arrow_back
                          ? SizedBox(
                              width: width * 0.125,
                              height: width * 0.125,
                              child: Icon(
                                widget.icon,
                                size: width * 0.075,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: width * 0.5,
                                child: Text(
                                  widget.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 0.0275 * height,
                                  ),
                                ),
                              ),
                            ),
            );
          },
        ),
      ),
    );
  }
}
