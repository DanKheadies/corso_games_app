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

class ScoreView extends StatefulWidget {
  const ScoreView({
    Key? key,
    required this.pieces,
  }) : super(key: key);

  final List<GamePiece> pieces;

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  @override
  Widget build(BuildContext context) {
    // TextStyle style = Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w300,);
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
                // style: style,
              ),
            ],
          );
        },
      ),
    );
  }
}
