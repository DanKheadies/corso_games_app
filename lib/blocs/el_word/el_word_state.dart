part of 'el_word_bloc.dart';

enum ElWordStatus {
  initial,
  loading,
  loaded,
  solved,
  wrong,
  reset, // TODO
  error,
}

class ElWordState extends Equatable {
  final ElWordStatus status;
  final Word solution;
  final List<Word> guesses;
  final int letterCount;
  final bool isNewWord;
  final bool isNotInDictionary;

  const ElWordState({
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
    // print('el word to json');
    return {
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
        status,
        solution,
        guesses,
        letterCount,
        isNewWord,
        isNotInDictionary,
      ];
}
