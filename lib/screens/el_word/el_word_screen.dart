import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/screens/screens.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class ElWordScreen extends StatelessWidget {
  static const String routeName = '/el-word';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ElWordScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ElWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'El Word',
      infoTitle: 'El Word',
      infoDetails:
          'Try to guess the word. Green is good. Pink is close but no cigar. Try it in another spot. The other pink (maroon) await their fate. And if it\'s in a dark, unreachable void, it means it\'s dead. Leave it.. Unless you\'re in dark mode. Then light isn\'t right. Leave it..',
      backgroundOverride: Colors.transparent,
      content: const ElGameScreen(),
      screenFunction: (String string) {},
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Settings',
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Share',
              icon: Icon(
                Icons.ios_share_outlined,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingButton: FloatingActionButton(
        onPressed: () {
          Word.resetGuesses();
          context.read<ElWordBloc>().add(
                ResetElWord(),
              );
        },
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
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
      floatingButtonLoc: FloatingActionButtonLocation.startDocked,
    );
  }
}
