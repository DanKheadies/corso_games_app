// import 'dart:convert';
// import 'dart:io';

import 'package:corso_games_app/blocs/blocs.dart';
// import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/widgets/widgets.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'dart:html' as webFile;

class HoneygramGame extends StatefulWidget {
  final HoneygramState honeygram;

  const HoneygramGame({
    super.key,
    required this.honeygram,
  });

  @override
  State<HoneygramGame> createState() => _HoneygramGameState();
}

class _HoneygramGameState extends State<HoneygramGame> {
  List<int> otherLettersOrder = List<int>.generate(6, (i) => i);

  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textController.addListener(handleTextChanged);
  }

  List<String> scrambledOtherLetters() {
    List<String> otherLetters = widget.honeygram.board.otherLetters;
    List<String> scrambledLetters = <String>[];
    for (int i = 0; i < otherLetters.length; i++) {
      scrambledLetters.add(otherLetters[otherLettersOrder[i]]);
    }
    return scrambledLetters;
  }

  String? validateGuessedWord(String guessedWord) {
    if (guessedWord.length < 4) {
      return 'Words must be at least 4 letters.';
    }

    if (widget.honeygram.wordsInOrderFound.contains(guessedWord)) {
      return 'Already found "$guessedWord"';
    }

    if (!guessedWord.contains(widget.honeygram.board.center)) {
      return '"$guessedWord" does not contain the center letter "${widget.honeygram.board.center}"';
    }

    if (!widget.honeygram.board.validWords.contains(guessedWord)) {
      return '"$guessedWord" is not a valid word';
    }
    return null;
  }

  void handleDelete() {
    textController.text =
        textController.text.substring(0, textController.text.length - 1);
  }

  void handleEnter() {
    var guessedWord = textController.text.toLowerCase();

    setState(() {
      textController.text = "";
      textController.clear();
    });
    FocusScope.of(context).unfocus();

    String? errorMessage = validateGuessedWord(guessedWord);

    if (errorMessage != null) {
      final snackBar = SnackBar(content: Text(errorMessage));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    context.read<HoneygramBloc>().add(
          FoundWord(
            word: guessedWord,
          ),
        );
  }

  void handleLetterPressed(String letter) {
    textController.text += letter;
  }

  void handleScamble() {
    setState(() {
      otherLettersOrder.shuffle();
    });
  }

  void handleTextChanged() {
    final String text = textController.text.toUpperCase();
    textController.value = textController.value.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
      composing: TextRange.empty,
    );

    setState(() {});
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Column(
        children: [
          const SizedBox(height: 25),
          // TODO: implement when we can get the difficulty working
          // Note: prob don't need to load boards manually anymore
          // GestureDetector(
          //   onLongPress: () async {
          //     context.read<HoneygramBloc>().add(
          //           UpdateBoard(),
          //         );
          //     Future.delayed(const Duration(milliseconds: 300));
          //     context.read<HoneygramBloc>().add(
          //           LoadHoneygramBoard(
          //             context: context,
          //             loadFromFile: false,
          //           ),
          //         );
          //   },
          //   child: HoneygramDifficulty(
          //     difficultyPercentile: widget.honeygram.board.difficultyPercentile,
          //   ),
          // ),
          // const SizedBox(height: 15),
          HoneygramProgress(
            validWords: widget.honeygram.board.validWords,
            wordsInOrderFound: widget.honeygram.wordsInOrderFound,
          ),
          const SizedBox(height: 10),
          HoneygramFoundWords(
            wordsInOrderFound: widget.honeygram.wordsInOrderFound,
            board: widget.honeygram.board,
          ),
          const SizedBox(height: 20),
          TextField(
            // TODO: add a focus scope to avoid keyboard shenanigans
            controller: textController,
            onSubmitted: (value) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            onEditingComplete: handleEnter,
          ),
          const SizedBox(height: 30),
          HoneygramButtons(
            center: widget.honeygram.board.center,
            otherLetters: scrambledOtherLetters(),
            typeLetter: handleLetterPressed,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textController.text != ''
                  ? GameButton(
                      forHoneygram: true,
                      icon: Icons.backspace,
                      isIconic: true,
                      title: 'Delete',
                      onPress: textController.text == '' ? null : handleDelete,
                    )
                  : const SizedBox(),
              // const SizedBox(width: 20),
              GameButton(
                forHoneygram: true,
                icon: Icons.shuffle,
                isIconic: true,
                title: 'Scramble',
                onPress: handleScamble,
              ),
              // const SizedBox(width: 20),
              textController.text != ''
                  ? GameButton(
                      forHoneygram: true,
                      icon: Icons.check,
                      isIconic: true,
                      title: 'Enter',
                      onPress: (textController.text == "" ||
                              widget.honeygram.status == HoneygramStatus.hasWon)
                          ? null
                          : handleEnter,
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 75),
        ],
      ),
    );
  }
}
