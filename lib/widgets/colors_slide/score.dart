import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:corso_games_app/widgets/colors_slide/controller.dart';
import 'package:corso_games_app/widgets/colors_slide/game_piece.dart';

class ScoreModel extends ChangeNotifier {
  ScoreModel();
  int _value = 0;

  int get value => _value;
  set value(x) {
    _value = x;
    notifyListeners();
  }
}

class Score extends StatefulWidget {
  const Score({
    Key? key,
    required this.pieces,
  }) : super(key: key);

  final List<GamePiece> pieces;

  @override
  State<Score> createState() => _Score();
}

class _Score extends State<Score> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Controller.score,
      child: Consumer<ScoreModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 12,
                ),
                child: Text('score:'),
              ),
              Text(
                model.value.toString(),
              ),
            ],
          );
        },
      ),
    );
  }
}
