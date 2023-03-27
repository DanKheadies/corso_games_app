import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';

class Score extends StatefulWidget {
  const Score({
    Key? key,
  }) : super(key: key);

  @override
  State<Score> createState() => _Score();
}

class _Score extends State<Score> {
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
          if (state.status != ColorsSlideStatus.error) {
            return Text(
              state.score.toString(),
            );
          } else {
            return const Text('error');
          }
        }),
      ],
    );
  }
}
