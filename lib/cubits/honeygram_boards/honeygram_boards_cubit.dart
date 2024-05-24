import 'package:corso_games_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'honeygram_boards_state.dart';

class HoneygramBoardsCubit extends HydratedCubit<HoneygramBoardsState> {
  HoneygramBoardsCubit() : super(HoneygramBoardsState.initial());

  Future<List<HoneygramBoard>> loadBoardsFromFile({
    required dynamic data,
  }) async {
    emit(
      state.copyWith(
        honeygramBoards: [],
        status: HoneygramBoardsStatus.loading,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1500));

    var bList = data as List;
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

    emit(
      state.copyWith(
        honeygramBoards: boardsList,
        status: HoneygramBoardsStatus.loaded,
      ),
    );
    print('returing baords:');
    print(boardsList.length);

    return boardsList;
  }

  @override
  HoneygramBoardsState? fromJson(Map<String, dynamic> json) {
    return HoneygramBoardsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HoneygramBoardsState state) {
    return state.toJson();
  }
}
