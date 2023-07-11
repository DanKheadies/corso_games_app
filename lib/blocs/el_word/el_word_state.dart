part of 'el_word_bloc.dart';

enum ElWordDifficulty {
  normal,
  hard,
}

enum ElWordStatus {
  initial,
  loading,
  loaded,
  solved,
  wrong,
  // reset,
  error,
}

class ElWordState extends Equatable {
  final ElWordDifficulty difficulty;
  final ElWordStatus status;
  final Word solution;
  final List<Word> guesses;
  final int letterCount;
  final bool isNewWord;
  final bool isNotInDictionary;

  const ElWordState({
    this.difficulty = ElWordDifficulty.normal,
    this.status = ElWordStatus.initial,
    this.solution = const Word(),
    this.guesses = const [],
    this.letterCount = 0,
    this.isNewWord = false,
    this.isNotInDictionary = false,
  });

  factory ElWordState.fromJson(Map<String, dynamic> json) {
    var list = json['guesses'] as List;
    List<Word> guessesList = list.map((word) => Word.fromJson(word)).toList();

    return ElWordState(
      difficulty: ElWordDifficulty.values.firstWhere(
        (difficulty) => difficulty.name.toString() == json['difficulty'],
      ),
      status: ElWordStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
      solution: Word.fromJson(json['solution']),
      guesses: guessesList,
      letterCount: json['letterCount'],
      isNewWord: json['isNewWord'],
      isNotInDictionary: json['isNotInDictionary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'difficulty': difficulty.name,
      'status': status.name,
      'solution': solution.toJson(),
      'guesses': guesses,
      'letterCount': letterCount,
      'isNewWord': isNewWord,
      'isNotInDictionary': isNotInDictionary,
    };
  }

  @override
  List<Object> get props => [
        difficulty,
        status,
        solution,
        guesses,
        letterCount,
        isNewWord,
        isNotInDictionary,
      ];
}
