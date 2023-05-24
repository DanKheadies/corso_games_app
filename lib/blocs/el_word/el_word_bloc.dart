import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:corso_games_app/models/models.dart';

part 'el_word_event.dart';
part 'el_word_state.dart';

class ElWordBloc extends HydratedBloc<ElWordEvent, ElWordState> {
  ElWordBloc() : super(const ElWordState()) {
    on<LoadElWord>(_onLoadGame);
    on<ResetElWord>(_onResetGame);
    on<UpdateGuess>(_onUpdateGuess);
    on<ValidateGuess>(_onValidateGuess);
  }

  void _onLoadGame(
    LoadElWord event,
    Emitter<ElWordState> emit,
  ) async {
    if (state.status == ElWordStatus.loaded) return;

    String wordsFile = await loadDictionary();
    List<String> words = wordsFile.split('\n');
    int randomIndex = Random().nextInt(words.length);
    String word = words[randomIndex];
    word.toUpperCase();

    Word elWord = Word(
      letters: <Letter>[
        Letter(
          letter: word.substring(0, 1),
          evaluation: Evaluation.correct,
        ),
        Letter(
          letter: word.substring(1, 2),
          evaluation: Evaluation.correct,
        ),
        Letter(
          letter: word.substring(2, 3),
          evaluation: Evaluation.correct,
        ),
        Letter(
          letter: word.substring(3, 4),
          evaluation: Evaluation.correct,
        ),
        Letter(
          letter: word.substring(4, 5),
          evaluation: Evaluation.correct,
        ),
      ],
    );

    emit(
      ElWordState(
        status: ElWordStatus.loaded,
        solution: elWord,
        guesses: Word.guesses,
      ),
    );
  }

  void _onResetGame(
    ResetElWord event,
    Emitter<ElWordState> emit,
  ) async {
    // TODO: combine w/ load game

    String wordsFile = await loadDictionary();
    List<String> words = wordsFile.split('\n');
    int randomIndex = Random().nextInt(words.length);
    String word = words[randomIndex];
    word.toUpperCase();

    Word elWord = Word(
      letters: <Letter>[
        Letter(
          letter: word.substring(0, 1),
          evaluation: Evaluation.correct,
        ),
        Letter(
          letter: word.substring(1, 2),
          evaluation: Evaluation.correct,
        ),
        Letter(
          letter: word.substring(2, 3),
          evaluation: Evaluation.correct,
        ),
        Letter(
          letter: word.substring(3, 4),
          evaluation: Evaluation.correct,
        ),
        Letter(
          letter: word.substring(4, 5),
          evaluation: Evaluation.correct,
        ),
      ],
    );

    emit(
      ElWordState(
        status: ElWordStatus.loaded,
        solution: elWord,
        guesses: Word.guesses,
      ),
    );
  }

  void _onUpdateGuess(
    UpdateGuess event,
    Emitter<ElWordState> emit,
  ) async {
    final state = this.state;
    if (state.status == ElWordStatus.loaded) {
      int letterCount;

      List<Word> guesses = (state.guesses.map((word) {
        return word.id == event.word.id ? event.word : word;
      })).toList();

      var prevWordIndex = (state.letterCount / 5).floor() - 1;

      if (prevWordIndex >= 0) {
        if (guesses[prevWordIndex].letters[0].evaluation ==
                Evaluation.pending &&
            guesses[prevWordIndex].letters[4] !=
                const Letter(
                  letter: '',
                  evaluation: Evaluation.missing,
                ) &&
            !event.isCheckBtn &&
            !event.isBackArrow) {
          return;
        }
      }

      if (event.isBackArrow) {
        letterCount = state.letterCount - 1;
      } else if (event.isCheckBtn) {
        letterCount = state.letterCount;
      } else {
        letterCount = state.letterCount + 1;
      }

      emit(
        ElWordState(
          status: ElWordStatus.loaded,
          solution: state.solution,
          guesses: guesses,
          letterCount: letterCount,
          isNewWord: letterCount % 5 == 0 && event.isBackArrow,
        ),
      );

      if (event.isCheckBtn) {
        String wordsFile = await loadDictionary();
        List<String> dictionary = wordsFile.split('\n');

        if (dictionary.contains(
          event.word.letters
              .map((letter) => letter.letter)
              .join()
              .toLowerCase(),
        )) {
          add(
            ValidateGuess(word: event.word),
          );
        } else {
          List<Word> guesses = (state.guesses.map((word) {
            return word.id == event.word.id
                ? Word(
                    id: event.word.id,
                    letters: List.generate(
                      5,
                      (index) => Letter(
                        id: index,
                        letter: '',
                        evaluation: Evaluation.pending,
                      ),
                    ),
                  )
                : word;
          })).toList();

          emit(
            ElWordState(
              status: ElWordStatus.loaded,
              solution: state.solution,
              guesses: guesses,
              letterCount: letterCount - 5,
              isNewWord: true,
              isNotInDictionary: true,
            ),
          );
        }
      }
    }
  }

  void _onValidateGuess(
    ValidateGuess event,
    Emitter<ElWordState> emit,
  ) {
    final state = this.state;
    if (state.status == ElWordStatus.loaded) {
      List<String> solution = state.solution.letters
          .map((letter) => letter.letter.toUpperCase())
          .toList();
      List<String> guess =
          event.word.letters.map((letter) => letter.letter).toList();
      List<Letter?> letters = event.word.letters;

      var evaluation = [];

      if (listEquals(solution, guess)) {
        emit(
          ElWordState(
            status: ElWordStatus.solved,
            solution: Word(
              id: 0,
              letters: state.solution.letters,
            ),
          ),
        );
      } else if (state.guesses[5].letters[0] !=
          const Letter(
            id: 0,
            letter: '',
            evaluation: Evaluation.pending,
          )) {
        emit(
          ElWordState(
            status: ElWordStatus.wrong,
            solution: state.solution,
          ),
        );
      } else {
        guess.asMap().forEach(
          (index, value) {
            if (guess[index] == solution[index]) {
              evaluation.add(Evaluation.correct);
              letters[index] = letters[index]!.copyWith(
                evaluation: Evaluation.correct,
              );
            } else if (solution.contains(guess[index])) {
              evaluation.add(Evaluation.present);
              letters[index] = letters[index]!.copyWith(
                evaluation: Evaluation.present,
              );
            } else {
              evaluation.add(Evaluation.missing);
              letters[index] = letters[index]!.copyWith(
                evaluation: Evaluation.missing,
              );
            }
          },
        );
        List<Word> validatedGuesses = state.guesses.map((guess) {
          return guess.id == event.word.id ? event.word : guess;
        }).toList();

        emit(
          ElWordState(
            status: ElWordStatus.loaded,
            solution: state.solution,
            guesses: validatedGuesses,
            letterCount: state.letterCount,
            isNewWord: true,
          ),
        );
      }
    }
  }

  Future<String> loadDictionary() async {
    return await rootBundle.loadString('assets/el_word/words_full.txt');
  }

  @override
  ElWordState? fromJson(Map<String, dynamic> json) {
    return ElWordState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ElWordState state) {
    return state.toJson();
  }
}
