part of 'honeygram_boards_cubit.dart';

enum HoneygramBoardsStatus {
  initial,
  loaded,
  loading,
  error,
}

class HoneygramBoardsState extends Equatable {
  final HoneygramBoardsStatus status;
  final List<HoneygramBoard> honeygramBoards;

  const HoneygramBoardsState({
    required this.honeygramBoards,
    required this.status,
  });

  @override
  List<Object> get props => [
        honeygramBoards,
        status,
      ];

  factory HoneygramBoardsState.initial() {
    return const HoneygramBoardsState(
      honeygramBoards: [],
      status: HoneygramBoardsStatus.initial,
    );
  }

  HoneygramBoardsState copyWith({
    HoneygramBoardsStatus? status,
    List<HoneygramBoard>? honeygramBoards,
  }) {
    return HoneygramBoardsState(
      honeygramBoards: honeygramBoards ?? this.honeygramBoards,
      status: status ?? this.status,
    );
  }

  factory HoneygramBoardsState.fromJson(Map<String, dynamic> json) {
    var bList = json['honeygramBoards'] as List;
    List<HoneygramBoard> boardsList = [];

    // Loop thru JSON list and store in List of HoneygramBoards
    for (int i = 0; i < bList.length; i++) {
      List<String> otherLettersList = (bList[i]['otherLetters'] as List)
          .map((letter) => letter as String)
          .toList();
      List<String> validWordsList = (bList[i]['validWords'] as List)
          .map((word) => word as String)
          .toList();
      double diffPercentile = bList[i]['difficultyPercentile'] ?? 0.0;

      boardsList.add(
        HoneygramBoard(
          center: bList[i]['center'],
          otherLetters: otherLettersList,
          validWords: validWordsList,
          difficultyPercentile: diffPercentile,
          difficultyScore: bList[i]['difficultyScore'],
        ),
      );
    }

    return HoneygramBoardsState(
      honeygramBoards: boardsList,
      status: HoneygramBoardsStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    var boardsList = [];
    for (int i = 0; i < honeygramBoards.length; i++) {
      boardsList.add(honeygramBoards[i].toJson());
    }

    return {
      'honeygramBoards': boardsList,
      'status': status.name,
    };
  }
}
