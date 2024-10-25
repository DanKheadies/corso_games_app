import 'package:corso_games_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CSSize extends StatelessWidget {
  const CSSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorsSlideBloc, ColorsSlideState>(
      builder: (context, state) {
        if (state.colorsStatus != ColorsSlideStatus.error) {
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
                '${state.colorsSize}x${state.colorsSize}',
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
