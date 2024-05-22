// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

import 'dart:convert';
import 'dart:math';

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
  HoneygramBloc() : super(const HoneygramState()) {
    on<FoundWord>(_onFoundWord);
    on<GetNewHoneygramBoard>(_onGetNewHoneygramBoard);
    on<LoadBoardsFromFile>(_onLoadBoardsFromFile);
    on<LoadHoneygramBoard>(_onLoadHoneygramBoard);
    // on<SaveBoardsToJSON>(_onSaveBoardsToJSON);
    on<UpdateBoard>(_onUpdateBoard);
  }

  void _onFoundWord(
    FoundWord event,
    Emitter<HoneygramState> emit,
  ) {
    print('found word');
    List<String> words = state.wordsInOrderFound.toList();
    words.add(event.word);
    print('done');

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
    int randomNumber = Random().nextInt(state.boards!.length);

    emit(
      state.copyWith(
        board: state.boards![randomNumber],
        wordsInOrderFound: [],
      ),
    );
  }

  void _onLoadBoardsFromFile(
    LoadBoardsFromFile event,
    Emitter<HoneygramState> emit,
  ) async {
    print('load boards from file');
    // print(event.data);

    emit(
      state.copyWith(
        boards: [],
        status: HoneygramStatus.loading,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1500));

    print('done waiting..');

    var bList = event.data as List;
    List<HoneygramBoard> boardsList = [];

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

    print('newBoards added');
    int randomNumber = Random().nextInt(boardsList.length);

    emit(
      state.copyWith(
        board: boardsList[randomNumber],
        boards: boardsList,
        status: HoneygramStatus.loaded,
        wordsInOrderFound: [],
      ),
    );
  }

  void _onLoadHoneygramBoard(
    LoadHoneygramBoard event,
    Emitter<HoneygramState> emit,
  ) async {
    print('load board via bloc');
    if (state.status == HoneygramStatus.loading) return;

    emit(
      state.copyWith(
        status: HoneygramStatus.loading,
      ),
    );

    if (event.loadFromFile && state.boards!.isEmpty) {
      print('load from file AND state is empty');
      String platformLocation = kIsWeb ? 'data/' : 'assets/data/';
      final ByteData boardsBytes = await rootBundle
          .load('${platformLocation}honeygram/precompiled-boards.txt');
      final Uint8List boardsIntsList = boardsBytes.buffer.asUint8List();
      var boardsStringList = utf8.decode(boardsIntsList);
      var boardsJsonList = jsonDecode(boardsStringList);

      add(
        LoadBoardsFromFile(
          data: boardsJsonList,
        ),
      );
    } else if (state.boards!.isEmpty) {
      print('boards is empty, soooo do work');
      String platformLocation = kIsWeb ? 'data/' : 'assets/data/';
      var defAssetBundle = DefaultAssetBundle.of(event.context);

      // TODO: remove once main "crunch" can be fixed
      // Generating a "simulated wait" so the user knows it's crunching
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
      // )..removeAt(0);
      // print(wordFrequencies);
      // print(wordFrequencies.length);
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
      print('all done');

      emit(
        state.copyWith(
          board: boards[randomNumber],
          boards: boards,
          status: HoneygramStatus.loaded,
          wordsInOrderFound: [],
        ),
      );
    } else {
      print('g2g');
      emit(
        state.copyWith(
          status: HoneygramStatus.loaded,
        ),
      );
    }
  }

  // void _onSaveBoardsToJSON(
  //   SaveBoardsToJSON event,
  //   Emitter<HoneygramState> emit,
  // ) {}

  void _onUpdateBoard(
    UpdateBoard event,
    Emitter<HoneygramState> emit,
  ) {
    emit(
      state.copyWith(
        board: HoneygramBoard.emptyHoneygramBoard,
        boards: [],
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
