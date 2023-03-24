import 'package:equatable/equatable.dart';

import 'package:corso_games_app/models/models.dart';

class Word extends Equatable {
  final int id;
  final List<Letter> letters;

  const Word({
    this.id = 0,
    this.letters = const [],
  });

  Word copyWith({
    int? id,
    List<Letter>? letters,
  }) {
    return Word(
      id: id ?? this.id,
      letters: letters ?? this.letters,
    );
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    var list = json['letters'] as List;
    List<Letter> lettersList =
        list.map((letter) => Letter.fromJson(letter)).toList();

    return Word(
      id: json['id'],
      letters: lettersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'letters': letters,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      letters,
    ];
  }

  static List<Word> guesses = [
    Word(
      id: 0,
      letters: List.generate(
        5,
        (index) => Letter(
          id: index,
          letter: '',
          evaluation: Evaluation.pending,
        ),
      ),
    ),
    Word(
      id: 1,
      letters: List.generate(
        5,
        (index) => Letter(
          id: index,
          letter: '',
          evaluation: Evaluation.pending,
        ),
      ),
    ),
    Word(
      id: 2,
      letters: List.generate(
        5,
        (index) => Letter(
          id: index,
          letter: '',
          evaluation: Evaluation.pending,
        ),
      ),
    ),
    Word(
      id: 3,
      letters: List.generate(
        5,
        (index) => Letter(
          id: index,
          letter: '',
          evaluation: Evaluation.pending,
        ),
      ),
    ),
    Word(
      id: 4,
      letters: List.generate(
        5,
        (index) => Letter(
          id: index,
          letter: '',
          evaluation: Evaluation.pending,
        ),
      ),
    ),
    Word(
      id: 5,
      letters: List.generate(
        5,
        (index) => Letter(
          id: index,
          letter: '',
          evaluation: Evaluation.pending,
        ),
      ),
    ),
  ];

  static void resetGuesses() {
    guesses = [
      Word(
        id: 0,
        letters: List.generate(
          5,
          (index) => Letter(
            id: index,
            letter: '',
            evaluation: Evaluation.pending,
          ),
        ),
      ),
      Word(
        id: 1,
        letters: List.generate(
          5,
          (index) => Letter(
            id: index,
            letter: '',
            evaluation: Evaluation.pending,
          ),
        ),
      ),
      Word(
        id: 2,
        letters: List.generate(
          5,
          (index) => Letter(
            id: index,
            letter: '',
            evaluation: Evaluation.pending,
          ),
        ),
      ),
      Word(
        id: 3,
        letters: List.generate(
          5,
          (index) => Letter(
            id: index,
            letter: '',
            evaluation: Evaluation.pending,
          ),
        ),
      ),
      Word(
        id: 4,
        letters: List.generate(
          5,
          (index) => Letter(
            id: index,
            letter: '',
            evaluation: Evaluation.pending,
          ),
        ),
      ),
      Word(
        id: 5,
        letters: List.generate(
          5,
          (index) => Letter(
            id: index,
            letter: '',
            evaluation: Evaluation.pending,
          ),
        ),
      ),
    ];
  }
}
