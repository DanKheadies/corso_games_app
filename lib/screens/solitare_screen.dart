import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class SolitareScreen extends StatefulWidget {
  static const String routeName = '/solitare';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SolitareScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SolitareScreen({super.key});

  @override
  State<SolitareScreen> createState() => _SolitareScreenState();
}

class _SolitareScreenState extends State<SolitareScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: 'Solitare',
      infoTitle: 'Solitare',
      infoDetails:
          'Stack cards sequentially in their suit. You can reveal new cards by moving opposite colored cards onto cards that are one higher than their own value, e.g. a red six can be placed on a black seven.',
      button: 'Leggooo!',
      backgroundOverride: Theme.of(context).colorScheme.tertiary,
      content: BlocBuilder<SolitareBloc, SolitareState>(
        builder: (context, state) {
          if (state.solitareStatus == SolitareStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.solitareStatus != SolitareStatus.error) {
            return SolitareBoard(
              resetSolitare: state.resetSolitare,
              allCards: state.allCards,
              cardColumn1: state.cardColumn1,
              cardColumn2: state.cardColumn2,
              cardColumn3: state.cardColumn3,
              cardColumn4: state.cardColumn4,
              cardColumn5: state.cardColumn5,
              cardColumn6: state.cardColumn6,
              cardColumn7: state.cardColumn7,
              cardDeckClosed: state.cardDeckClosed,
              cardDeckOpened: state.cardDeckOpened,
              finalClubsDeck: state.finalClubsDeck,
              finalDiamondsDeck: state.finalDiamondsDeck,
              finalHeartsDeck: state.finalHeartsDeck,
              finalSpadesDeck: state.finalSpadesDeck,
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
      screenFunction: (String string) {},
      // bottomBar: const BottomAppBar(),
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
          context.read<SolitareBloc>().add(
                ToggleSolitare(),
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
            context.read<SolitareBloc>().add(
                  ToggleSolitare(),
                );
          },
        ),
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
