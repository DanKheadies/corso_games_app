part of 'el_word_bloc.dart';

class ElWordEvent extends Equatable {
  const ElWordEvent();

  @override
  List<Object> get props => [];
}

class LoadElWord extends ElWordEvent {}

class ResetElWord extends ElWordEvent {}

class UpdateGuess extends ElWordEvent {
  final Word word;
  final bool isBackArrow;
  final bool isCheckBtn;
  final bool isNormalBtn;

  const UpdateGuess({
    required this.word,
    this.isBackArrow = false,
    this.isCheckBtn = false,
    this.isNormalBtn = false,
  });

  @override
  List<Object> get props => [
        word,
        isBackArrow,
        isCheckBtn,
        isNormalBtn,
      ];
}

class ValidateGuess extends ElWordEvent {
  final Word word;

  const ValidateGuess({
    required this.word,
  });

  @override
  List<Object> get props => [word];
}
