import 'package:equatable/equatable.dart';

class HoneygramBucket extends Equatable {
  final int first;
  final int last;
  final int sum;

  const HoneygramBucket({
    required this.first,
    required this.last,
    required this.sum,
  });

  @override
  List<Object> get props => [
        first,
        last,
        sum,
      ];

  HoneygramBucket copyWith({
    int? first,
    int? last,
    int? sum,
  }) {
    return HoneygramBucket(
      first: first ?? this.first,
      last: last ?? this.last,
      sum: sum ?? this.sum,
    );
  }

  factory HoneygramBucket.fromJson(Map<String, dynamic> json) {
    return HoneygramBucket(
      first: json['first'] ?? 0,
      last: json['last'] ?? 0,
      sum: json['sum'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'sum': sum,
    };
  }

  static const emptyHoneygramBucket = HoneygramBucket(
    first: 0,
    last: 0,
    sum: 0,
  );
}
