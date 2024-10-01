import 'package:corso_games_app/providers/stack_stacks/stack_stacks_provider.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StacksStackWidget extends StatelessWidget {
  final int index;
  final double height;
  final List<StacksBrickWidget> bricks;
  final Function onTap;

  const StacksStackWidget({
    super.key,
    required this.index,
    required this.height,
    required this.bricks,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Consumer<StackStacksProvider>(
          builder: (context, provider, child) {
            return AnimatedSlide(
              offset: Offset(
                0,
                provider.stackIndex == index ? -0.1 : 0,
              ),
              duration: const Duration(milliseconds: 50),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1],
                    colors: [Colors.white, Color(0xFF1d2d44)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                // height: 140,
                height: height / 5,
                width: 50,
                child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: bricks,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
