import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

class HoneygramScreen extends StatelessWidget {
  const HoneygramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      screen: 'Honeygram',
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
                tooltip: 'Stats',
                icon: Icon(
                  Icons.stacked_bar_chart,
                  color: Theme.of(context).colorScheme.background,
                  size: 30,
                ),
                onPressed: () {
                  print('go to stats');
                  // context.goNamed('honeygramStats');
                },
              ),
            ),
          ],
        ),
      ),
      infoTitle: 'Honeygram',
      infoDetails:
          'See how many 4+ letter words you can make from the letters provided. Each word must contain the center word, and letters can be repeated.',
      flactionButton: FloatingActionButton(
        onPressed: () {
          context.read<HoneygramBloc>().add(
                LoadHoneygramBoard(
                  context: context,
                ),
              );
        },
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(
            // Icons.settings_backup_restore_rounded,
            Icons.hexagon,
            color: Theme.of(context).colorScheme.background,
            size: 30,
          ),
          onPressed: () {
            context.read<HoneygramBloc>().add(
                  LoadHoneygramBoard(
                    context: context,
                  ),
                );
          },
        ),
      ),
      // flactionButton: FloatingActionButton(
      //   onPressed: () {
      //     print('initiate next game');
      //   },
      //   tooltip: 'New Game',
      //   child: const Icon(Icons.refresh_outlined),
      // ),
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      screenFunction: (_) {},
      useSingleScroll: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<HoneygramBloc, HoneygramState>(
              builder: (context, state) {
                if (state.status == HoneygramStatus.initial ||
                    state.status == HoneygramStatus.loading) {
                  print('loading honeygram...');
                  return const CustomCenter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 25),
                        Text('Please wait. Honey can be slow to pour..'),
                      ],
                    ),
                  );
                }
                if (state.status == HoneygramStatus.loaded) {
                  print('loaded honeygram!');
                  print(state.board);
                  if (state.board != HoneygramBoard.emptyHoneygramBoard) {
                    return HoneygramGame(
                      honeygram: state,
                    );
                  } else {
                    return const Text(
                      'There was an error with the honey. Please refresh and try again.',
                    );
                  }
                }
                if (state.status == HoneygramStatus.hasWon) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('A winner is you 🎉'),
                    ),
                  );
                  return const Text('Huzzah!');
                } else {
                  return const Text('Something went wrong.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
