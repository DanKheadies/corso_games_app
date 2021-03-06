import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/el_word/el_word_bloc.dart';
import 'package:corso_games_app/models/el_word/letter.dart';
import 'package:corso_games_app/models/el_word/word.dart';
import 'package:corso_games_app/widgets/el_word/custom_board_tile.dart';
import 'package:corso_games_app/widgets/el_word/custom_keyboard.dart';

class ElGameScreen extends StatelessWidget {
  static const String id = 'el-game';

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
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<ElWordBloc, ElWordState>(
      listenWhen: (previous, current) {
        if (current is ElWordLoaded) {
          return current.isNotInDictionary;
        }
        return false;
      },
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('That word is not in the Corso dictionary.'),
            duration: Duration(seconds: 3),
          ),
        );
      },
      builder: (context, state) {
        if (state is ElWordLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          );
        }
        if (state is ElWordLoaded) {
          // print(state.solution);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBoard(context, state),
              const CustomKeyboard(),
            ],
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
                      // fontSize: 32,
                      fontSize: height * .04,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    'The word was ',
                    style: TextStyle(
                      fontSize: height * .04,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(height: height * 0.025),
                  Text(
                    state.solution,
                    style: TextStyle(
                      // fontSize: 42,
                      fontSize: height * .055,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  // const SizedBox(height: 50),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15)),
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
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
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}
