part of 'el_word_bloc.dart';

@immutable
abstract class ElWordEvent extends Equatable {
  const ElWordEvent();

  @override
  List<Object> get props => [];
}

class LoadGame extends ElWordEvent {}

class UpdateGuess extends ElWordEvent {
  final Word word;
  final bool isBackArrow;
  final bool isCheckBtn;

  const UpdateGuess({
    required this.word,
    this.isBackArrow = false,
    this.isCheckBtn = false,
  });

  @override
  List<Object> get props => [word, isBackArrow, isCheckBtn];
}

class ValidateGuess extends ElWordEvent {
  final Word word;

  const ValidateGuess({
    required this.word,
  });

  @override
  List<Object> get props => [word];
}
