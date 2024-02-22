import 'package:flutter/material.dart';

class BirdBarrier extends StatelessWidget {
  final bool isThisBottomBarrier;
  final double barrierHeight;
  final double barrierWidth;
  final double barrierX;

  const BirdBarrier({
    super.key,
    required this.barrierHeight,
    required this.barrierWidth,
    required this.barrierX,
    required this.isThisBottomBarrier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
        (2 * barrierX + barrierWidth) / (2 - barrierWidth),
        isThisBottomBarrier ? 1 : -1,
      ),
      child: Container(
        color: Colors.green,
        height:
            MediaQuery.of(context).size.height * (3 / 4) * (barrierHeight / 2),
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
      ),
    );
  }
}
