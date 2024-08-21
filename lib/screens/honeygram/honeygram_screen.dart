import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: IconButton(
                tooltip: 'Stats',
                icon: Icon(
                  Icons.stacked_bar_chart,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 30,
                ),
                onPressed: () {
                  context.goNamed('honeygramStats');
                },
              ),
            ),
            SizedBox(
              child: IconButton(
                tooltip: 'Words',
                icon: Icon(
                  Icons.list,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 30,
                ),
                onPressed: () {
                  context.goNamed('honeygramWords');
                },
              ),
            ),
          ],
        ),
      ),
      infoTitle: 'Honeygram',
      infoDetails:
          'See how many 4+ letter words you can make from the letters provided. Each word must contain the center word, and letters can be repeated. The game will be slow to load on the first load up.',
      flactionButton: FloatingActionButton(
        onPressed: () {
          context.read<HoneygramBloc>().add(
                const GetNewHoneygramBoard(),
              );
        },
        tooltip: 'New Board',
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(
            Icons.hexagon,
            color: Theme.of(context).colorScheme.onSurface,
            size: 30,
          ),
          onPressed: () {
            context.read<HoneygramBloc>().add(
                  const GetNewHoneygramBoard(),
                );
          },
        ),
      ),
      flactionButtonLoc: FloatingActionButtonLocation.centerDocked,
      screenFunction: (_) {},
      useSingleScroll: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<HoneygramBoardsCubit, HoneygramBoardsState>(
              builder: (context, cubit) {
                return BlocBuilder<HoneygramBloc, HoneygramState>(
                  builder: (context, state) {
                    if ((state.status == HoneygramStatus.initial ||
                            state.status == HoneygramStatus.loading) &&
                        (cubit.status == HoneygramBoardsStatus.initial ||
                            cubit.status == HoneygramBoardsStatus.loading)) {
                      return const CustomCenter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 25),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              child: Text(
                                'Please wait..',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              child: Text(
                                'Honey can be slow to pour...',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              child: Text(
                                'Don\'t worry, honey won\'t freeze.',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              child: Text(
                                'The screen isn\'t frozen.',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              child: Text(
                                'The bees are working overtime right now.',
                              ),
                            ),
                            SizedBox(height: 25),
                          ],
                        ),
                      );
                    }
                    if (state.status == HoneygramStatus.loaded &&
                        cubit.status == HoneygramBoardsStatus.loaded) {
                      if (state.board != HoneygramBoard.emptyHoneygramBoard) {
                        return HoneygramGame(
                          honeygram: state,
                        );
                      } else {
                        return const CustomCenter(
                          child: Text(
                            'There was an error with the bees. Please refresh and try again.',
                          ),
                        );
                      }
                    }
                    if (state.status == HoneygramStatus.hasWon) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('A winner is you 🎉'),
                        ),
                      );
                      return const CustomCenter(
                        child: Text(
                          'Huzzah! You were a busy, little bee!',
                        ),
                      );
                    } else {
                      return const CustomCenter(
                        child: Text(
                          'Something went wrong.',
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
