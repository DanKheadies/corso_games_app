import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StackStacksGame extends StatefulWidget {
  final List<StacksStackWidget> stacksStackWidgets;

  const StackStacksGame({
    super.key,
    required this.stacksStackWidgets,
  });

  @override
  State<StackStacksGame> createState() => _StackStacksGameState();
}

class _StackStacksGameState extends State<StackStacksGame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).scaffoldBackgroundColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...getGameElements(widget.stacksStackWidgets),
        ],
      ),
    );
  }

  List<Widget> getGameElements(List<StacksStackWidget> brickStackWidgets) {
    const int rowFlex = 3;
    return [
      // const Spacer(),
      const SizedBox(height: 20),
      Flexible(
        flex: rowFlex,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: brickStackWidgets.getRange(0, 4).toList(),
        ),
      ),
      const Spacer(),
      Flexible(
        flex: rowFlex,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: brickStackWidgets.getRange(4, 8).toList(),
        ),
      ),
      const Spacer(),
      Flexible(
        flex: rowFlex,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: brickStackWidgets.getRange(8, 13).toList(),
        ),
      ),
      const Spacer(),
    ];
  }
}
