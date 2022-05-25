import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:corso_games_app/models/el_word/letter.dart';
import 'package:corso_games_app/models/el_word/word.dart';

part 'el_word_event.dart';
part 'el_word_state.dart';

class ElWordBloc extends Bloc<ElWordEvent, ElWordState> {
  ElWordBloc()
      : super(
          ElWordLoading(),
        ) {
    on<LoadGame>(_onLoadGame);
    on<UpdateGuess>(_onUpdateGuess);
    on<ValidateGuess>(_onValidateGuess);
  }

  void _onLoadGame(
    LoadGame event,
    Emitter<ElWordState> emit,
  ) async {
    String wordsFile = await rootBundle.loadString('assets/el_word/words.txt');
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

    var dictionary = await rootBundle.loadString('assets/el_word/words.txt');

    emit(
      ElWordLoaded(
        solution: elWord,
        dictionary: dictionary.split('\n'),
        guesses: Word.guesses,
      ),
    );
  }

  void _onUpdateGuess(
    UpdateGuess event,
    Emitter<ElWordState> emit,
  ) {
    print('update');
    final state = this.state;
    if (state is ElWordLoaded) {
      print('yea');
      int letterCount;
      // if (!event.isCheckBtn) {
      //   print('not check');
      switch (event.isBackArrow) {
        case true:
          letterCount = state.letterCount - 1;
          break;
        default:
          letterCount = state.letterCount + 1;
      }
      // } else {
      //   letterCount = 5;
      // }

      List<Word> guesses = (state.guesses.map((word) {
        return word.id == event.word.id ? event.word : word;
      })).toList();

      emit(
        ElWordLoaded(
          solution: state.solution,
          dictionary: state.dictionary,
          guesses: guesses,
          letterCount: letterCount,
        ),
      );

      if (letterCount % 5 == 0 && !event.isBackArrow) {
        // if (letterCount % 5 == 0 && !event.isBackArrow && event.isCheckBtn) {
        print('do the thing');
        if (state.dictionary.contains(
          event.word.letters
              .map((letter) => letter!.letter)
              .join()
              .toLowerCase(),
        )) {
          add(
            ValidateGuess(word: event.word),
          );
        } else {
          List<Word> guesses = (state.guesses.map(
            (word) {
              return word.id == event.word.id
                  ? Word(
                      id: event.word.id,
                      letters: List.generate(
                        5,
                        (index) => null,
                      ),
                    )
                  : word;
            },
          )).toList();

          emit(
            ElWordLoaded(
              solution: state.solution,
              dictionary: state.dictionary,
              guesses: guesses,
              letterCount: letterCount - 5,
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
    if (state is ElWordLoaded) {
      List<String> solution = state.solution.letters
          .map((letter) => letter!.letter.toUpperCase())
          .toList();
      List<String> guess =
          event.word.letters.map((letter) => letter!.letter).toList();
      List<Letter?> letters = event.word.letters;

      var evaluation = [];

      if (listEquals(solution, guess)) {
        emit(ElWordSolved(solution: solution.join("")));
      } else {
        guess.asMap().forEach(
          (index, value) {
            // if (identical(guess[index], solution[index])) {
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
          ElWordLoaded(
            dictionary: state.dictionary,
            solution: state.solution,
            guesses: validatedGuesses,
            letterCount: state.letterCount,
          ),
        );
      }
    }
  }
}
