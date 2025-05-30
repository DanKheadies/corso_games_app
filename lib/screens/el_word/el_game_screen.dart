import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElGameScreen extends StatelessWidget {
  const ElGameScreen({super.key});

  Widget _buildBoard(BuildContext context, ElWordState state) {
    double height = Responsive.isMobile(context) || Responsive.isTablet(context)
        ? MediaQuery.of(context).size.height
        : 800;
    double width = Responsive.isMobile(context) || Responsive.isTablet(context)
        ? MediaQuery.of(context).size.width
        : 800;

    return SizedBox(
      height: height *
          (Responsive.isMobile(context) || Responsive.isTablet(context)
              ? .475
              : .5),
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
    double height = Responsive.isMobile(context) || Responsive.isTablet(context)
        ? MediaQuery.of(context).size.height
        : 800;

    return BlocConsumer<ElWordBloc, ElWordState>(
      listenWhen: (previous, current) {
        if (current.status == ElWordStatus.loaded) {
          return current.isNotInDictionary;
        }
        return false;
      },
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('That word is not in this Corso dictionary.'),
            duration: Duration(seconds: 3),
          ),
        );
      },
      builder: (context, state) {
        if (state.status == ElWordStatus.loading ||
            state.status == ElWordStatus.initial) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }
        if (state.status == ElWordStatus.loaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
                Responsive.isMobile(context) || Responsive.isTablet(context)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
            children: [
              _buildBoard(context, state),
              const CustomKeyboard(),
            ],
          );
        }
        if (state.status == ElWordStatus.wrong) {
          List<String> solution = state.solution.letters
              .map((letter) => letter.letter.toUpperCase())
              .toList();
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sorry Charlie..',
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
                    solution.join(''),
                    style: TextStyle(
                      fontSize: height * .055,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.all(15),
                    ),
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
                            LoadElWord(),
                          );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        if (state.status == ElWordStatus.solved) {
          List<String> solution = state.solution.letters
              .map((letter) => letter.letter.toUpperCase())
              .toList();
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
                    solution.join(''),
                    style: TextStyle(
                      fontSize: height * .055,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.all(15),
                    ),
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
                            LoadElWord(),
                          );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Something went wrong.'),
          );
        }
      },
    );
  }
}
