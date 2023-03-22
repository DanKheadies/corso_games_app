import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class ElGameScreen extends StatelessWidget {
  // static const String id = 'el-game';
  static const String routeName = '/el-game';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ElGameScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ElGameScreen({Key? key}) : super(key: key);

  Widget _buildBoard(BuildContext context, ElWordLoaded state) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * .475,
      width: width > 620 ? width * .5 : width * .8,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          // Get all the letters in a word.
          List<Letter?> letters = state.guesses[(index / 5).floor()].letters;
          // Count the number of letters in the selected word.
          int letterCount =
              letters.where((letter) => letter != null).toList().length;
          // For each letter, get the index (the position in the word).
          int letterIndex = index % 5;

          return CustomBoardTile(
            letters: letters,
            letterCount: letterCount,
            letterIndex: letterIndex,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return BlocConsumer<ElWordBloc, ElWordState>(
      listenWhen: (previous, current) {
        if (current is ElWordLoaded) {
          return current.isNotInDictionary;
        }
        return false;
      },
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'That word is not in the Corso dictionary.',
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      },
      builder: (context, state) {
        if (state is ElWordLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }
        if (state is ElWordLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBoard(context, state),
              const CustomKeyboard(),
            ],
          );
        }
        if (state is ElWordWrong) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sorry Charlie..',
                    style: TextStyle(
                      // fontSize: 32,
                      fontSize: height * .04,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    'The word was ',
                    style: TextStyle(
                      fontSize: height * .04,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  Text(
                    state.solution,
                    style: TextStyle(
                      fontSize: height * .055,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)),
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        // fontSize: 18,
                        fontSize: height * 0.025,
                      ),
                    ),
                    onPressed: () {
                      Word.resetGuesses();
                      context.read<ElWordBloc>().add(
                            LoadGame(),
                          );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ElWordSolved) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Congrats, you won!',
                    style: TextStyle(
                      fontSize: height * .04,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    'The word was ',
                    style: TextStyle(
                      fontSize: height * .04,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  Text(
                    state.solution,
                    style: TextStyle(
                      fontSize: height * .055,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)),
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: height * 0.025,
                      ),
                    ),
                    onPressed: () {
                      Word.resetGuesses();
                      context.read<ElWordBloc>().add(
                            LoadGame(),
                          );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}
