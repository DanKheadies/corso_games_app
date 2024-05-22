// import 'dart:convert';
// import 'dart:io';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/blocs/honeygram/honeygram_bloc.dart';
import 'package:corso_games_app/widgets/widgets.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    print('validate guess');
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
      print('guessWord: $guessedWord');
      return '"$guessedWord" is not a valid word';
    }
    return null;
  }

  void handleDelete() {
    textController.text =
        textController.text.substring(0, textController.text.length - 1);
  }

  void handleEnter() {
    print('handle eenter');
    var guessedWord = textController.text.toLowerCase();

    setState(() {
      textController.text = "";
    });

    String? errorMessage = validateGuessedWord(guessedWord);

    if (errorMessage != null) {
      print('show message');
      final snackBar = SnackBar(content: Text(errorMessage));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    context.read<HoneygramBloc>().add(
          FoundWord(
            word: guessedWord,
          ),
        );
    print('enter handled');
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
          GestureDetector(
            onLongPress: () async {
              context.read<HoneygramBloc>().add(
                    UpdateBoard(),
                  );
              Future.delayed(const Duration(milliseconds: 300));
              context.read<HoneygramBloc>().add(
                    LoadHoneygramBoard(
                      context: context,
                      loadFromFile: false,
                    ),
                  );
            },
            child: HoneygramDifficulty(
              difficultyPercentile: widget.honeygram.board.difficultyPercentile,
            ),
          ),
          const SizedBox(height: 15),
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
            autofocus: true,
            controller: textController,
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
          GameButton(
            icon: Icons.abc,
            isIconic: false,
            title: 'Scramble',
            onPress: handleScamble,
          ),
          const SizedBox(height: 20),
          textController.text != ''
              ? GameButton(
                  icon: Icons.abc,
                  isIconic: false,
                  title: 'Delete',
                  onPress: textController.text == '' ? null : handleDelete,
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          textController.text != ''
              ? GameButton(
                  icon: Icons.abc,
                  isIconic: false,
                  title: 'Enter',
                  onPress: (textController.text == "" ||
                          widget.honeygram.status == HoneygramStatus.hasWon)
                      ? null
                      : handleEnter,
                )
              : const SizedBox(),
          // const SizedBox(height: 50),
          // GameButton(
          //   isIconic: false,
          //   icon: Icons.abc,
          //   onPress: () {
          //     // var toJson = context.read<HoneygramBloc>().state.toJson();
          //     var hgState = context.read<HoneygramBloc>().state;
          //     var boardsList = [];
          //     for (int i = 0; i < hgState.boards.length; i++) {
          //       boardsList.add(hgState.boards[i].toJson());
          //     }
          //     var toJson = jsonEncode(boardsList);
          //     var blob = webFile.Blob([toJson], 'text/plain', 'native');

          //     webFile.AnchorElement(
          //       href: webFile.Url.createObjectUrlFromBlob(blob).toString(),
          //     )
          //       ..setAttribute("download", "precompiled-boards.txt")
          //       ..click();
          //   },
          //   title: 'toJSON',
          // ),
          // const SizedBox(height: 25),
          // GameButton(
          //   isIconic: false,
          //   icon: Icons.abc,
          //   onPress: () async {
          //     var hgBlocCont = context.read<HoneygramBloc>();
          //     FilePickerResult? result = await FilePicker.platform.pickFiles();

          //     print('done picking');
          //     if (result != null) {
          //       print('not null');
          //       // print(result.files.first);
          //       // print(result.files.first.path!);
          //       final Uint8List fileBytes = result.files.first.bytes!;
          //       //   final String fileName = image.files.first.name;
          //       // File file = File().openRead().transform(fileBytes);
          //       var decoder = utf8.decode(fileBytes);
          //       print('we haz file');
          //       print(decoder);
          //       // Map mapValue = jsonDecode(decoder);
          //       print('**************** DACO **************');
          //       // var derp = jsonEncode(decoder);
          //       // print(derp);
          //       // print(mapValue);
          //       print('**************** TACO **************');
          //       // hgBlocCont.fromJson(mapValue as Map<String, dynamic>);
          //       // hgBlocCont.fromJson(decoder);
          //       var derpDeDerp = jsonDecode(decoder);
          //       print(derpDeDerp);
          //       // hgBlocCont.fromJson(derpDeDerp);
          //       print('**************** FLAME **************');
          //       print(derpDeDerp[0]);

          //       hgBlocCont.add(
          //         LoadBoardsFromFile(
          //           data: derpDeDerp,
          //         ),
          //       );
          //     } else {
          //       // User canceled the picker
          //     }
          //   },
          //   title: 'fromJson',
          // ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
