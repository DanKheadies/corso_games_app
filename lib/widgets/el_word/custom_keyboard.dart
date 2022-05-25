import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/el_word/el_word_bloc.dart';
import 'package:corso_games_app/models/el_word/letter.dart';
import 'package:corso_games_app/widgets/el_word/custom_key.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> firstRow = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
    List<String> secondRow = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
    List<String> thirdRow = ['Z', 'X', 'C', 'V', 'B', 'N', 'M'];

    return BlocBuilder<ElWordBloc, ElWordState>(
      builder: (context, state) {
        if (state is ElWordLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ElWordLoaded) {
          var letters = state.guesses
              .expand((element) => element.letters)
              .where((element) => element != null)
              .toSet();

          var missingLetters = letters
              .where((letter) => letter!.evaluation == Evaluation.missing)
              .map((letter) => letter!.letter);

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...firstRow.map(
                    (letter) => CustomKey(
                      text: letter,
                      evaluation: letters,
                      onTap: () {
                        // print(state.letterCount);
                        // if (state.letterCount >= 5) print('yolo');
                        // if (missingLetters.contains(letter) ||
                        //     state.letterCount >= 5) return;
                        if (missingLetters.contains(letter)) return;

                        var wordIndex = (state.letterCount / 5).floor();
                        var letterIndex = state.letterCount % 5;
                        var letters = state.guesses[wordIndex].letters;

                        letters[letterIndex] = Letter(
                          id: state.letterCount,
                          letter: letter,
                          evaluation: Evaluation.pending,
                        );

                        var updateWord =
                            state.guesses[wordIndex].copyWith(letters: letters);

                        context.read<ElWordBloc>().add(
                              UpdateGuess(word: updateWord),
                            );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...secondRow.map(
                    (letter) => CustomKey(
                      text: letter,
                      evaluation: letters,
                      onTap: () {
                        if (missingLetters.contains(letter)) return;

                        var wordIndex = (state.letterCount / 5).floor();
                        var letterIndex = state.letterCount % 5;
                        var letters = state.guesses[wordIndex].letters;

                        letters[letterIndex] = Letter(
                          id: state.letterCount,
                          letter: letter,
                          evaluation: Evaluation.pending,
                        );

                        var updateWord =
                            state.guesses[wordIndex].copyWith(letters: letters);

                        context.read<ElWordBloc>().add(
                              UpdateGuess(word: updateWord),
                            );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  ...thirdRow.map(
                    (letter) => CustomKey(
                      text: letter,
                      evaluation: letters,
                      onTap: () {
                        if (missingLetters.contains(letter)) return;

                        var wordIndex = (state.letterCount / 5).floor();
                        var letterIndex = state.letterCount % 5;
                        var letters = state.guesses[wordIndex].letters;

                        letters[letterIndex] = Letter(
                          id: state.letterCount,
                          letter: letter,
                          evaluation: Evaluation.pending,
                        );

                        var updateWord =
                            state.guesses[wordIndex].copyWith(letters: letters);

                        context.read<ElWordBloc>().add(
                              UpdateGuess(word: updateWord),
                            );
                      },
                    ),
                  ),
                  Container(
                    width: 55,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary,
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(4),
                    child: InkWell(
                      onTap: () {
                        // if (state.letterCount % 5 != 0 ||
                        //     state.letterCount == 5) {
                        if (state.letterCount % 5 != 0) {
                          print('mmeeeeee');
                          var wordIndex = (state.letterCount / 5).floor();
                          var letterIndex = (state.letterCount - 1) % 5;
                          var letters = state.guesses[wordIndex].letters;

                          letters.removeAt(letterIndex);
                          letters.add(null);

                          var updatedWord = state.guesses[wordIndex]
                              .copyWith(letters: letters);

                          context.read<ElWordBloc>().add(
                                UpdateGuess(
                                  word: updatedWord,
                                  isBackArrow: true,
                                ),
                              );
                        }
                      },
                      child: Center(
                        child: Text(
                          'Erase',
                          style: TextStyle(
                            // fontSize: 18,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary,
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () {
                          print('check');
                          print(state.letterCount);
                          if (state.letterCount % 5 == 0) {
                            print('kk');
                            var wordIndex = (state.letterCount / 5).floor();
                            // var letterIndex = (state.letterCount - 1) % 5;
                            var letters = state.guesses[wordIndex].letters;

                            // letters.removeAt(letterIndex);
                            // letters.add(null);

                            var updatedWord = state.guesses[wordIndex]
                                .copyWith(letters: letters);

                            context.read<ElWordBloc>().add(
                                  UpdateGuess(
                                    word: updatedWord,
                                    isCheckBtn: true,
                                  ),
                                );
                          }
                        },
                        child: Center(
                          child: Text(
                            'Check',
                            style: TextStyle(
                              // fontSize: 18,
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}
