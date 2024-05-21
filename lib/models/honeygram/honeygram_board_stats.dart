import 'package:corso_games_app/models/models.dart';
import 'package:equatable/equatable.dart';

class HoneygramBoardStats extends Equatable {
  final List<HoneygramBucket> maxScores;
  final List<HoneygramBucket> numberOfAnswers;
  final List<HoneygramWordCount> centerLetters;
  final List<HoneygramWordCount> commonWords;
  final List<HoneygramWordCount> validLetters;

  const HoneygramBoardStats({
    required this.centerLetters,
    required this.commonWords,
    required this.maxScores,
    required this.numberOfAnswers,
    required this.validLetters,
  });

  @override
  List<Object> get props => [
        centerLetters,
        commonWords,
        maxScores,
        numberOfAnswers,
        validLetters,
      ];

  HoneygramBoardStats copyWith({
    List<HoneygramBucket>? maxScores,
    List<HoneygramBucket>? numberOfAnswers,
    List<HoneygramWordCount>? centerLetters,
    List<HoneygramWordCount>? commonWords,
    List<HoneygramWordCount>? validLetters,
  }) {
    return HoneygramBoardStats(
      centerLetters: centerLetters ?? this.centerLetters,
      commonWords: commonWords ?? this.commonWords,
      maxScores: maxScores ?? this.maxScores,
      numberOfAnswers: numberOfAnswers ?? this.numberOfAnswers,
      validLetters: validLetters ?? this.validLetters,
    );
  }

  factory HoneygramBoardStats.fromJson(Map<String, dynamic> json) {
    List<HoneygramBucket> maxScoresList = (json['maxScores'] as List)
        .map((score) => HoneygramBucket.fromJson(score))
        .toList();
    List<HoneygramBucket> numberOfAnswersList =
        (json['numberOfAnswers'] as List)
            .map((answers) => HoneygramBucket.fromJson(answers))
            .toList();
    List<HoneygramWordCount> centerLettersList = (json['centerLetters'] as List)
        .map((letters) => HoneygramWordCount.fromJson(letters))
        .toList();
    List<HoneygramWordCount> commonWordsList = (json['commonWords'] as List)
        .map((words) => HoneygramWordCount.fromJson(words))
        .toList();
    List<HoneygramWordCount> validLettersList = (json['validLetters'] as List)
        .map((letters) => HoneygramWordCount.fromJson(letters))
        .toList();

    return HoneygramBoardStats(
      centerLetters: centerLettersList,
      commonWords: commonWordsList,
      maxScores: maxScoresList,
      numberOfAnswers: numberOfAnswersList,
      validLetters: validLettersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'centerLetters': centerLetters,
      'commonWords': commonWords,
      'maxScores': maxScores,
      'numberOfAnswers': numberOfAnswers,
      'validLetters': validLetters,
    };
  }

  static const emptyHoneygramBoardStats = HoneygramBoardStats(
    centerLetters: [],
    commonWords: [],
    maxScores: [],
    numberOfAnswers: [],
    validLetters: [],
  );
}
