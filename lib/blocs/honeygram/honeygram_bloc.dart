import 'dart:convert';
import 'dart:math';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/services.dart';

part 'honeygram_event.dart';
part 'honeygram_state.dart';

class HoneygramBloc extends HydratedBloc<HoneygramEvent, HoneygramState> {
  final HoneygramBoardsCubit _honeygramCubit;

  HoneygramBloc({
    required HoneygramBoardsCubit honeygramCubit,
  })  : _honeygramCubit = honeygramCubit,
        super(const HoneygramState()) {
    on<FoundWord>(_onFoundWord);
    on<GetNewHoneygramBoard>(_onGetNewHoneygramBoard);
    on<LoadHoneygramBoard>(_onLoadHoneygramBoard);
    on<UpdateBoard>(_onUpdateBoard);
  }

  void _onFoundWord(
    FoundWord event,
    Emitter<HoneygramState> emit,
  ) {
    List<String> words = state.wordsInOrderFound.toList();
    words.add(event.word);

    emit(
      state.copyWith(
        status: words.length == state.board.validWords.length
            ? HoneygramStatus.hasWon
            : HoneygramStatus.loaded,
        wordsInOrderFound: words,
      ),
    );
  }

  void _onGetNewHoneygramBoard(
    GetNewHoneygramBoard event,
    Emitter<HoneygramState> emit,
  ) {
    int randomNumber =
        Random().nextInt(_honeygramCubit.state.honeygramBoards.length);

    emit(
      state.copyWith(
        board: _honeygramCubit.state.honeygramBoards[randomNumber],
        wordsInOrderFound: [],
      ),
    );
  }

  void _onLoadHoneygramBoard(
    LoadHoneygramBoard event,
    Emitter<HoneygramState> emit,
  ) async {
    if (state.status == HoneygramStatus.loading) return;

    emit(
      state.copyWith(
        status: HoneygramStatus.loading,
      ),
    );

    if (event.loadFromFile && _honeygramCubit.state.honeygramBoards.isEmpty) {
      String platformLocation = kIsWeb ? 'data/' : 'assets/data/';
      final ByteData boardsBytes = await rootBundle
          .load('${platformLocation}honeygram/precompiled-boards.txt');
      final Uint8List boardsIntsList = boardsBytes.buffer.asUint8List();
      var boardsStringList = utf8.decode(boardsIntsList);
      var boardsJsonList = jsonDecode(boardsStringList);

      List<HoneygramBoard> boardsList =
          await _honeygramCubit.loadBoardsFromFile(
        data: boardsJsonList,
      );

      int randomNumber = Random().nextInt(boardsList.length);

      emit(
        state.copyWith(
          board: boardsList[randomNumber],
          status: HoneygramStatus.loaded,
          wordsInOrderFound: [],
        ),
      );
    } else if (_honeygramCubit.state.honeygramBoards.isEmpty) {
      String platformLocation = kIsWeb ? 'data/' : 'assets/data/';
      var defAssetBundle = DefaultAssetBundle.of(event.context);

      await Future.delayed(const Duration(milliseconds: 300));

      String wordListString =
          await rootBundle.loadString('${platformLocation}honeygram/words.txt');
      List<String> words = wordListString.trim().split('\n');

      // Remove whitespace to avoid issues down the line
      List<String> wordList = [];
      for (String word in words) {
        wordList.add(word.trim());
      }

      var wordFrequenciesCSV = await defAssetBundle.loadString(
        '${platformLocation}honeygram/frequencies.csv',
      );
      List<List<dynamic>> wordFrequencies = const CsvToListConverter().convert(
        wordFrequenciesCSV,
        eol: '\n',
      );
      Map<String, int> wordFrequenciesMap = Map.fromEntries(
        wordFrequencies.map(
          (value) => MapEntry(
            value[0].toString().trim(),
            value[1],
          ),
        ),
      );
      HoneygramWordFrequencies frequencies = HoneygramWordFrequencies(
        wordToFrequency: wordFrequenciesMap,
      );

      List<HoneygramBoard> boards = await generateHoneygramBoards(
        wordList: wordList,
        frequencies: frequencies,
      );

      int randomNumber = Random().nextInt(boards.length);

      _honeygramCubit.state.copyWith(
        honeygramBoards: boards,
      );

      emit(
        state.copyWith(
          board: boards[randomNumber],
          status: HoneygramStatus.loaded,
          wordsInOrderFound: [],
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: HoneygramStatus.loaded,
        ),
      );
    }
  }

  void _onUpdateBoard(
    UpdateBoard event,
    Emitter<HoneygramState> emit,
  ) {
    emit(
      state.copyWith(
        board: HoneygramBoard.emptyHoneygramBoard,
        status: HoneygramStatus.initial,
        wordsInOrderFound: [],
      ),
    );
  }

  @override
  HoneygramState? fromJson(Map<String, dynamic> json) {
    return HoneygramState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HoneygramState state) {
    return state.toJson();
  }
}
