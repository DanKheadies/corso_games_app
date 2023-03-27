import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';

class CSSize extends StatelessWidget {
  const CSSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
      builder: (context, state) {
        if (state.status != ColorsSlideStatus.error) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 12,
                ),
                child: Text('size:'),
              ),
              Text(
                '${state.size}x${state.size}',
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
