import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolitareScreen extends StatefulWidget {
  const SolitareScreen({super.key});

  @override
  State<SolitareScreen> createState() => _SolitareScreenState();
}

class _SolitareScreenState extends State<SolitareScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Solitare',
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        height: 45,
        padding: EdgeInsets.zero,
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
      button: 'Leggooo!',
      flactionButton: FloatingActionButton(
        onPressed: () {
          context.read<SolitareBloc>().add(
                ToggleSolitareReset(),
              );
        },
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(
            Icons.settings_backup_restore_rounded,
            color: Theme.of(context).colorScheme.onSurface,
            size: 30,
          ),
          onPressed: () {
            context.read<SolitareBloc>().add(
                  ToggleSolitareReset(),
                );
          },
        ),
      ),
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      infoTitle: 'Solitare',
      infoDetails:
          'Stack cards sequentially in their suit. You can reveal new cards by moving opposite colored cards onto cards that are one higher than their own value, e.g. a red six can be placed on a black seven.',
      screenFunction: (_) {},
      child: BlocBuilder<SolitareBloc, SolitareState>(
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
    );
  }
}
