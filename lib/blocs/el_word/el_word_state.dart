part of 'el_word_bloc.dart';

@immutable
abstract class ElWordState extends Equatable {
  const ElWordState();

  @override
  List<Object?> get props => [];
}

class ElWordLoading extends ElWordState {}

class ElWordLoaded extends ElWordState {
  final Word solution;
  final List<String> dictionary;
  final List<Word> guesses;
  final int letterCount;
  final bool isNewWord;
  final bool isNotInDictionary;

  const ElWordLoaded({
    required this.solution,
    required this.dictionary,
    required this.guesses,
    this.letterCount = 0,
    this.isNewWord = false,
    this.isNotInDictionary = false,
  });

  @override
  List<Object?> get props => [
        solution,
        dictionary,
        guesses,
        letterCount,
        isNewWord,
        isNotInDictionary,
      ];
}

class ElWordSolved extends ElWordState {
  final String solution;

  const ElWordSolved({
    required this.solution,
  });

  @override
  List<Object> get props => [solution];
}

class ElWordWrong extends ElWordState {
  final String solution;

  const ElWordWrong({
    required this.solution,
  });

  @override
  List<Object> get props => [solution];
}
