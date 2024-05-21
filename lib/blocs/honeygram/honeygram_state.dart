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
  final List<HoneygramBoard> boards;
  final List<String> wordsInOrderFound;

  const HoneygramState({
    this.board = HoneygramBoard.emptyHoneygramBoard,
    this.boards = const [],
    this.status = HoneygramStatus.initial,
    this.wordsInOrderFound = const [],
  });

  @override
  List<Object> get props => [
        board,
        boards,
        status,
        wordsInOrderFound,
      ];

  HoneygramState copyWith({
    HoneygramBoard? board,
    HoneygramStatus? status,
    List<HoneygramBoard>? boards,
    List<String>? wordsInOrderFound,
  }) {
    return HoneygramState(
      board: board ?? this.board,
      boards: boards ?? this.boards,
      status: status ?? this.status,
      wordsInOrderFound: wordsInOrderFound ?? this.wordsInOrderFound,
    );
  }

  factory HoneygramState.fromJson(Map<String, dynamic> json) {
    print('fromJson');
    List<HoneygramBoard> boardsList = (json['boards'] as List)
        .map((board) => board as HoneygramBoard)
        .toList();
    List<String> wordsInOrderFoundList = (json['wordsInOrderFound'] as List)
        .map((letters) => letters as String)
        .toList();

    print('boardsList: ${boardsList.length}');

    return HoneygramState(
      board: HoneygramBoard.fromJson(json['board']),
      boards: boardsList,
      status: HoneygramStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
      wordsInOrderFound: wordsInOrderFoundList,
    );
  }

  Map<String, dynamic> toJson() {
    print('toJson');
    print('boards: ${boards.length}');
    return {
      'board': board.toJson(),
      'boards': boards,
      'status': status.name,
      'wordsInOrderFound': wordsInOrderFound,
    };
  }
}
