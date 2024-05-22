part of 'honeygram_bloc.dart';

enum HoneygramStatus {
  initial,
  loading,
  loaded,
  error,
  hasWon,
}

class HoneygramState extends Equatable {
  final bool saveBoards;
  final HoneygramBoard board;
  final HoneygramStatus status;
  final List<HoneygramBoard>? boards;
  final List<String> wordsInOrderFound;

  const HoneygramState({
    this.board = HoneygramBoard.emptyHoneygramBoard,
    this.boards = const [],
    this.saveBoards = true,
    this.status = HoneygramStatus.initial,
    this.wordsInOrderFound = const [],
  });

  @override
  List<Object?> get props => [
        board,
        boards,
        saveBoards,
        status,
        wordsInOrderFound,
      ];

  HoneygramState copyWith({
    bool? saveBoards,
    HoneygramBoard? board,
    HoneygramStatus? status,
    List<HoneygramBoard>? boards,
    List<String>? wordsInOrderFound,
  }) {
    return HoneygramState(
      board: board ?? this.board,
      boards: boards ?? this.boards,
      saveBoards: saveBoards ?? this.saveBoards,
      status: status ?? this.status,
      wordsInOrderFound: wordsInOrderFound ?? this.wordsInOrderFound,
    );
  }

  factory HoneygramState.fromJson(Map<String, dynamic> json) {
    print('fromJson');
    // List<HoneygramBoard> boardsList = (json['boards'] as List)
    //     .map((board) => board as HoneygramBoard)
    //     .toList();
    // print(json['boards']);
    var bList = json['boards'] as List;
    // print(bList.length);
    // print(bList[0]);
    // print(bList[0]['center']);
    List<HoneygramBoard> boardsList = [];
    // print('no to clean up...');

    // Loop thru JSON list and store in List of HoneygramBoards
    for (int i = 0; i < bList.length; i++) {
      List<String> otherLettersList = (bList[i]['otherLetters'] as List)
          .map((letter) => letter as String)
          .toList();
      // print('otherLettersList');
      // print(otherLettersList);
      List<String> validWordsList = (bList[i]['validWords'] as List)
          .map((word) => word as String)
          .toList();
      // print('validWordsList');
      // print(validWordsList);
      double diffPercentile = bList[i]['difficultyPercentile'] ?? 0.0;
      // print('diffPercentile');
      // print(diffPercentile);

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
    List<String> wordsInOrderFoundList = (json['wordsInOrderFound'] as List)
        .map((letters) => letters as String)
        .toList();

    return HoneygramState(
      board: HoneygramBoard.fromJson(json['board']),
      boards: boardsList,
      saveBoards: json['saveBoards'],
      status: HoneygramStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
      wordsInOrderFound: wordsInOrderFoundList,
    );
  }

  Map<String, dynamic> toJson() {
    print('toJson');
    if (saveBoards) {
      print('save boards');
      // print('boards: ${boards.length}');
      var boardsList = [];
      for (int i = 0; i < boards!.length; i++) {
        boardsList.add(boards![i].toJson());
      }

      // TODO: slows down the app / experience when I try to save the ~50MB of
      // data every "toJson"
      copyWith(
        saveBoards: false,
      );
      print(saveBoards);

      return {
        'board': board.toJson(),
        'boards': boardsList,
        'saveBoards': false, // TODO: need to updat the state
        'status': status.name,
        'wordsInOrderFound': wordsInOrderFound,
      };
    } else {
      print('dont save boards');
      return {
        'board': board.toJson(),
        'saveBoards': saveBoards,
        'status': status.name,
        'wordsInOrderFound': wordsInOrderFound,
      };
    }
    // print('have boards');
    // // print('boards: ${boards.length}');
    // var boardsList = [];
    // if (boards != null) {
    //   for (int i = 0; i < boards!.length; i++) {
    //     boardsList.add(boards![i].toJson());
    //   }
    // }

    // // TODO: slows down the app / experience when I try to save the ~50MB of
    // // data every "toJson"

    // return {
    //   'board': board.toJson(),
    //   'boards': boardsList,
    //   'status': status.name,
    //   'wordsInOrderFound': wordsInOrderFound,
    // };
  }
}
