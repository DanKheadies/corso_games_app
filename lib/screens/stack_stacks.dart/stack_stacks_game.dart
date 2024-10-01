import 'package:corso_games_app/providers/providers.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StackStacksGame extends StatefulWidget {
  const StackStacksGame({super.key});

  @override
  State<StackStacksGame> createState() => _StackStacksGameState();
}

class _StackStacksGameState extends State<StackStacksGame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1d2d44),
            Color(0xFF0d1321),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ChangeNotifierProvider(
        create: (context) => StackStacksProvider(),
        child: Consumer<StackStacksProvider>(
          builder: (context, stacksProvider, child) {
            List<StacksStackWidget> stacksStackWidgets =
                stacksProvider.createBrickStackWidgetList(context);

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...getGameElements(stacksStackWidgets),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> getGameElements(List<StacksStackWidget> brickStackWidgets) {
    const int rowFlex = 3;
    return [
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
