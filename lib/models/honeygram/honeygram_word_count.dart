import 'package:equatable/equatable.dart';

class HoneygramWordCount extends Equatable {
  final int count;
  final String word;

  const HoneygramWordCount({
    required this.count,
    required this.word,
  });

  @override
  List<Object> get props => [
        count,
        word,
      ];

  HoneygramWordCount copyWith({
    int? count,
    String? word,
  }) {
    return HoneygramWordCount(
      count: count ?? this.count,
      word: word ?? this.word,
    );
  }

  factory HoneygramWordCount.fromJson(Map<String, dynamic> json) {
    return HoneygramWordCount(
      count: json['count'] ?? 0,
      word: json['word'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'word': word,
    };
  }

  static const emptyHoneygramWordCount = HoneygramWordCount(
    count: 0,
    word: '',
  );
}
