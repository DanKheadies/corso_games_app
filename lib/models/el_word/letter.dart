import 'package:equatable/equatable.dart';

enum Evaluation {
  pending,
  correct,
  missing,
  present,
}

class Letter extends Equatable {
  final int id;
  final String letter;
  final Evaluation evaluation;

  const Letter({
    this.id = 0,
    this.letter = '',
    this.evaluation = Evaluation.pending,
  });

  @override
  List<Object?> get props => [id, letter, evaluation];

  Letter copyWith({
    int? id,
    String? letter,
    Evaluation? evaluation,
  }) {
    return Letter(
      id: id ?? this.id,
      letter: letter ?? this.letter,
      evaluation: evaluation ?? this.evaluation,
    );
  }

  factory Letter.fromJson(Map<String, dynamic> json) {
    // print('Letter fromJson');
    return Letter(
      id: json['id'],
      letter: json['letter'],
      evaluation: Evaluation.values.firstWhere(
        (eval) => eval.name.toString() == json['evaluation'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    // print('Letter toJson');
    // print(id);
    // print(letter);
    // print(evaluation.name);
    return {
      'id': id,
      'letter': letter,
      'evaluation': evaluation.name,
    };
  }
}
