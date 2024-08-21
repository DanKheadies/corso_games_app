part of 'ball_bounce_cubit.dart';

enum BallBounceStatus {
  intro,
  playing,
  gameOver,
}

class BallBounceState extends Equatable {
  final BallBounceStatus status;
  final int highestScore;
  final int score;

  const BallBounceState({
    required this.highestScore,
    required this.score,
    required this.status,
  });

  @override
  List<Object> get props => [
        highestScore,
        score,
        status,
      ];

  factory BallBounceState.initial() {
    return const BallBounceState(
      highestScore: 0,
      score: 0,
      status: BallBounceStatus.intro,
    );
  }

  BallBounceState copyWith({
    BallBounceStatus? status,
    int? highestScore,
    int? score,
  }) {
    return BallBounceState(
      highestScore: highestScore ?? this.highestScore,
      score: score ?? this.score,
      status: status ?? this.status,
    );
  }

  factory BallBounceState.fromJson(Map<String, dynamic> json) {
    return BallBounceState(
      highestScore: json['highestScore'],
      score: json['score'],
      status: BallBounceStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'highestScore': highestScore,
      'score': score,
      'status': status.name,
    };
  }
}
