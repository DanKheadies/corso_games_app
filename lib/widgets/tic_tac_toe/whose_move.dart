import 'package:corso_games_app/providers/tic_tac_toe/game_provider.dart';
import 'package:corso_games_app/widgets/tic_tac_toe/shapes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WhoseMove extends StatelessWidget {
  const WhoseMove({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameProvider state = context.watch<GameProvider>();
    final Size size = MediaQuery.of(context).size;

    final style = TextStyle(
      // color: Colors.grey[800],
      color: Theme.of(context).colorScheme.surface,
      fontSize: state.getAdaptiveTextSize(context, 20),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "It's",
          style: style,
        ),
        if (state.xMove)
          Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.0125),
              child: XSign(
                shapeSize: size.height * 0.035,
                // state.getAdaptiveTextSize(
                //   context,
                //   size.width * 0.06,
                // ),
              ))
        else
          Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.0125),
              child: Circle(
                shapeSize: size.height * 0.035,
                // state.getAdaptiveTextSize(
                //   context,
                //   size.width * 0.06,
                // ),
              )),
        Text(
          'move',
          style: style,
        )
      ],
    );
  }
}
