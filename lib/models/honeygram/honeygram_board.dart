import 'package:equatable/equatable.dart';

class HoneygramBoard extends Equatable implements Comparable<HoneygramBoard> {
  final double? difficultyPercentile;
  final int difficultyScore;
  final List<String> otherLetters;
  final List<String> validWords;
  final String center;

  const HoneygramBoard({
    required this.center,
    this.difficultyPercentile,
    this.difficultyScore = 0,
    required this.otherLetters,
    required this.validWords,
  });

  @override
  List<Object?> get props => [
        center,
        difficultyPercentile,
        difficultyScore,
        otherLetters,
        validWords,
      ];

  HoneygramBoard copyWith({
    double? difficultyPercentile,
    int? difficultyScore,
    List<String>? otherLetters,
    List<String>? validWords,
    String? center,
  }) {
    return HoneygramBoard(
      center: center ?? this.center,
      difficultyPercentile: difficultyPercentile ?? this.difficultyPercentile,
      difficultyScore: difficultyScore ?? this.difficultyScore,
      otherLetters: otherLetters ?? this.otherLetters,
      validWords: validWords ?? this.validWords,
    );
  }

  factory HoneygramBoard.fromJson(Map<String, dynamic> json) {
    List<String> otherLettersList = (json['otherLetters'] as List)
        .map((letters) => letters as String)
        .toList();
    List<String> validWordsList = (json['validWords'] as List)
        .map((letters) => letters as String)
        .toList();

    return HoneygramBoard(
      center: json['center'] ?? '7',
      difficultyPercentile: json['difficultyPercentile'] ?? 0,
      difficultyScore: json['difficultyScore'] ?? 0,
      otherLetters: otherLettersList,
      validWords: validWordsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'center': center,
      'difficultyPercentile': difficultyPercentile,
      'difficultyScore': difficultyScore,
      'otherLetters': otherLetters,
      'validWords': validWords,
    };
  }

  @override
  int compareTo(HoneygramBoard other) => id.compareTo(other.id);

  int computeMaxScore() => validWords.fold(
        0,
        (previous, word) => previous + HoneygramBoard.scoreForWord(word),
      );

  String get id => "$center:${otherLetters.join('')}";

  static bool isValidId(String id) {
    return id.length == 8 && id[1] == ':';
  }

  static int scoreForWord(String word) {
    // Quoting http://varianceexplained.org/r/honeycomb-puzzle/
    // Four-letter words are worth 1 point each, while five-letter words are
    // worth 5 points, six-letter words are worth 6 points, seven-letter words
    // are worth 7 points, etc. Words that use all of the seven letters in the
    // honeycomb are known as “pangrams” and earn 7 bonus points (in addition
    // to the points for the length of the word). So in the above example,
    // MEGAPLEX is worth 15 points.

    int length = word.length;
    if (length < 4) {
      throw Exception("Only know how to score words above 4 letters.");
    }

    if (length == 4) return 1;
    int uniqueLetterCount = Set.from(word.split('')).length;
    // Assuming reasonable inputs (not checking for > 7).
    int pangramBonus = (uniqueLetterCount == 7) ? 7 : 0;
    return pangramBonus + length;
  }

  static const emptyHoneygramBoard = HoneygramBoard(
    center: '',
    difficultyPercentile: 0,
    difficultyScore: 0,
    otherLetters: [],
    validWords: [],
  );
}
