// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

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

    int randomNumber = 0;
    // List<HoneygramBoard> boards = [];

    if (state.boards.isEmpty) {
      print('boards is empty, soooo..');
      String platformLocation = kIsWeb ? 'data/' : 'assets/data/';
      var defAssetBundle = DefaultAssetBundle.of(event.context);

      // TODO: remove once main "crunch" can be fixed
      // Generating a "simulated wait" so the user knows it's crunching
      await Future.delayed(const Duration(milliseconds: 100));

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
      Map<String, int> derp = Map.fromEntries(
        wordFrequencies.map(
          (value) => MapEntry(
            value[0].toString().trim(),
            value[1],
          ),
        ),
      );
      HoneygramWordFrequencies frequencies = HoneygramWordFrequencies(
        wordToFrequency: derp,
      );
      // print(frequencies.wordToFrequency.length);
      // print(frequencies.wordToFrequency);
      print('daco');

      // Baords
      // HoneygramBoardGenerator hgBoardGenerator = HoneygramBoardGenerator();
      // List<HoneygramBoard> boards =
      //     await HoneygramBoardGenerator().generateBoards(
      List<HoneygramBoard> boards = await generateHoneygramBoards(
        // wordList: wordList,
        // wordList: words,
        wordList: wordList,
        frequencies: frequencies,
      );

      print('woof');
      // boards.sort();
      // TODO: why is the sort a problem? but also, no longer necessary either?

      print('flame');
      print(boards.length);
      randomNumber = Random().nextInt(boards.length);

      emit(
        state.copyWith(
          board: boards[randomNumber],
          // board: boards[0],
          boards: boards,
          status: HoneygramStatus.loaded,
        ),
      );
    } else {
      print('we haz boards');
      randomNumber = Random().nextInt(state.boards.length);

      emit(
        state.copyWith(
          board: state.boards[randomNumber],
          status: HoneygramStatus.loaded,
        ),
      );
    }
  }

  void _onUpdateBoard(
    UpdateBoard event,
    Emitter<HoneygramState> emit,
  ) {}

  @override
  HoneygramState? fromJson(Map<String, dynamic> json) {
    return HoneygramState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HoneygramState state) {
    return state.toJson();
  }
}
