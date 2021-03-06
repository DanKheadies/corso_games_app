import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/el_word/el_word_bloc.dart';
import 'package:corso_games_app/models/el_word/word.dart';
import 'package:corso_games_app/screens/el_word/el_game_screen.dart';
import 'package:corso_games_app/widgets/screen_wrapper.dart';

class ElWordScreen extends StatefulWidget {
  static const String id = 'el-word';

  const ElWordScreen({Key? key}) : super(key: key);

  @override
  State<ElWordScreen> createState() => _ElWordScreenState();
}

class _ElWordScreenState extends State<ElWordScreen> {
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
        bottomBar: BottomAppBar(
          color: Theme.of(context).colorScheme.tertiary,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                tooltip: 'Settings',
                icon: Icon(
                  Icons.settings,
                  // color: Colors.white,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Share',
                icon: Icon(
                  Icons.ios_share_outlined,
                  // color: Colors.white,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        floatingButton: BlocConsumer<ElWordBloc, ElWordState>(
          listener: (context, state) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('Idk...'),
            //     duration: Duration(seconds: 2),
            //   ),
            // );
          },
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Word.resetGuesses();
                context.read<ElWordBloc>().add(
                      LoadGame(),
                    );
              },
              tooltip: 'Reset',
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                icon: const Icon(
                  Icons.settings_backup_restore_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Word.resetGuesses();
                  context.read<ElWordBloc>().add(
                        LoadGame(),
                      );
                },
              ),
            );
          },
        ),
        floatingButtonLoc: FloatingActionButtonLocation.startDocked,
      ),
    );
  }
}
