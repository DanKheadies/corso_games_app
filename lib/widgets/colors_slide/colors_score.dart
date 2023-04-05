import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';

class ColorsScore extends StatefulWidget {
  const ColorsScore({
    Key? key,
  }) : super(key: key);

  @override
  State<ColorsScore> createState() => _ColorsScore();
}

class _ColorsScore extends State<ColorsScore> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 24,
            bottom: 12,
          ),
          child: Text('score:'),
        ),
        BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
            builder: (context, state) {
          if (state.colorsStatus != ColorsSlideStatus.error) {
            return Text(
              state.colorsScore.toString(),
            );
          } else {
            return const Text('error');
          }
        }),
      ],
    );
  }
}
