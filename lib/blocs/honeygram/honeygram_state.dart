part of 'honeygram_bloc.dart';

enum HoneygramStatus {
  initial,
  loading,
  loaded,
  error,
  hasWon,
}

class HoneygramState extends Equatable {
  final HoneygramBoard board;
  final HoneygramStatus status;
  final List<String> wordsInOrderFound;

  const HoneygramState({
    this.board = HoneygramBoard.emptyHoneygramBoard,
    this.status = HoneygramStatus.initial,
    this.wordsInOrderFound = const [],
  });

  @override
  List<Object> get props => [
        board,
        status,
        wordsInOrderFound,
      ];

  HoneygramState copyWith({
    HoneygramBoard? board,
    HoneygramStatus? status,
    List<String>? wordsInOrderFound,
  }) {
    return HoneygramState(
      board: board ?? this.board,
      status: status ?? this.status,
      wordsInOrderFound: wordsInOrderFound ?? this.wordsInOrderFound,
    );
  }

  factory HoneygramState.fromJson(Map<String, dynamic> json) {
    List<String> wordsInOrderFoundList = (json['wordsInOrderFound'] as List)
        .map((letters) => letters as String)
        .toList();

    return HoneygramState(
      board: HoneygramBoard.fromJson(json['board']),
      status: HoneygramStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
      wordsInOrderFound: wordsInOrderFoundList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'board': board.toJson(),
      'status': status.name,
      'wordsInOrderFound': wordsInOrderFound,
    };
  }
}
