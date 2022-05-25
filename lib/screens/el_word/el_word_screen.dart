import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/el_word/el_word_bloc.dart';
import 'package:corso_games_app/screens/el_word/el_game_screen.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class ElWordScreen extends StatefulWidget {
  static const String id = 'el-word';

  const ElWordScreen({Key? key}) : super(key: key);

  @override
  State<ElWordScreen> createState() => _ElWordScreenState();
}

class _ElWordScreenState extends State<ElWordScreen> {
  Widget _buildAppBar(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ElWordBloc()
        ..add(
          LoadGame(),
        ),
      child: ScreenWrapper(
        title: 'El Word',
        infoTitle: 'El Word',
        infoDetails: 'Good luck, have fun!',
        backgroundOverride: Colors.transparent,
        content: const ElGameScreen(),
        screenFunction: (String _string) {},
        bottomBar: _buildAppBar(context),
      ),
    );
  }
}
