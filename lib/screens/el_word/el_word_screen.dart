import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ElWordScreen extends StatelessWidget {
  const ElWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'El Word',
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                tooltip: 'Settings',
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.background,
                  size: 30,
                ),
                onPressed: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   ElSettingsScreen.routeName,
                  // );
                  context.goNamed('elWordSettings');
                },
              ),
            ),
          ],
        ),
      ),
      flactionButton: FloatingActionButton(
        onPressed: () {
          Word.resetGuesses();
          context.read<ElWordBloc>().add(
                ResetElWord(),
              );
        },
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(
            Icons.settings_backup_restore_rounded,
            color: Theme.of(context).colorScheme.background,
            size: 30,
          ),
          onPressed: () {
            Word.resetGuesses();
            context.read<ElWordBloc>().add(
                  ResetElWord(),
                );
          },
        ),
      ),
      flactionButtonLoc: FloatingActionButtonLocation.startDocked,
      infoTitle: 'El Word',
      infoDetails:
          'Try to guess the word. Green is good. Pink is close but no cigar. Try it in another spot. The other pink (maroon) await their fate. And if it\'s in a dark, unreachable void, it means it\'s dead. Leave it.. Unless you\'re in dark mode. Then light isn\'t right. Leave it..',
      screenFunction: (_) {},
      child: const ElGameScreen(),
    );
  }
}
