import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> firstRow = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
    List<String> secondRow = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
    List<String> thirdRow = ['Z', 'X', 'C', 'V', 'B', 'N', 'M'];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<ElWordBloc, ElWordState>(
      builder: (context, state) {
        if (state.status == ElWordStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == ElWordStatus.loaded) {
          var letters = state.guesses
              .expand((element) => element.letters)
              // .where((element) => element != null)
              .toSet();

          var missingLetters = letters
              .where((letter) => letter.evaluation == Evaluation.missing)
              .map((letter) => letter.letter);

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
                        if (missingLetters.contains(letter)) return;

                        var wordIndex = (state.letterCount / 5).floor();
                        var letters = state.guesses[wordIndex].letters;
                        var letterIndex = state.letterCount % 5;

                        if (state.letterCount % 5 != 0 ||
                            state.letterCount / 5 == state.letterCount % 5 ||
                            state.isNewWord) {
                          letters[letterIndex] = Letter(
                            id: state.letterCount,
                            letter: letter,
                            evaluation: Evaluation.pending,
                          );
                        }

                        var updateWord = state.guesses[wordIndex].copyWith(
                          letters: letters,
                        );

                        context.read<ElWordBloc>().add(
                              UpdateGuess(
                                word: updateWord,
                                isNormalBtn: true,
                              ),
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

                        if (state.letterCount % 5 != 0 ||
                            state.letterCount / 5 == state.letterCount % 5 ||
                            state.isNewWord) {
                          letters[letterIndex] = Letter(
                            id: state.letterCount,
                            letter: letter,
                            evaluation: Evaluation.pending,
                          );
                        }

                        var updateWord = state.guesses[wordIndex].copyWith(
                          letters: letters,
                        );

                        context.read<ElWordBloc>().add(
                              UpdateGuess(
                                word: updateWord,
                                isNormalBtn: true,
                              ),
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

                        if (state.letterCount % 5 != 0 ||
                            state.letterCount / 5 == state.letterCount % 5 ||
                            state.isNewWord) {
                          letters[letterIndex] = Letter(
                            id: state.letterCount,
                            letter: letter,
                            evaluation: Evaluation.pending,
                          );
                        }

                        var updateWord = state.guesses[wordIndex].copyWith(
                          letters: letters,
                        );

                        context.read<ElWordBloc>().add(
                              UpdateGuess(
                                word: updateWord,
                                isNormalBtn: true,
                              ),
                            );
                      },
                    ),
                  ),
                  Container(
                    width: width * .15,
                    height: height * .05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: !state.isNewWord && state.letterCount != 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.825),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(4),
                    child: InkWell(
                      onTap: () {
                        if (!state.isNewWord && state.letterCount != 0) {
                          var wordIndex = 0;
                          if (state.letterCount % 5 == 0) {
                            wordIndex = (state.letterCount / 5).floor() - 1;
                          } else {
                            wordIndex = (state.letterCount / 5).floor();
                          }

                          var letterIndex = (state.letterCount - 1) % 5;
                          var letters = state.guesses[wordIndex].letters;

                          letters.removeAt(letterIndex);
                          letters.add(
                            const Letter(
                              letter: '',
                              evaluation: Evaluation.pending,
                            ),
                          );

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
                            fontSize: height * .0175,
                            color: Theme.of(context).scaffoldBackgroundColor,
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
                      width: width * .333,
                      height: height * .05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: state.letterCount % 5 == 0 &&
                                    !state.isNewWord &&
                                    state.letterCount != 0
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.825),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () {
                          if (state.letterCount % 5 == 0 &&
                              !state.isNewWord &&
                              state.letterCount != 0) {
                            var wordIndex = (state.letterCount / 5).floor() - 1;
                            var letters = state.guesses[wordIndex].letters;

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
                              fontSize: height * .0175,
                              color: Theme.of(context).scaffoldBackgroundColor,
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
