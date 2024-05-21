import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HoneygramGame extends StatefulWidget {
  final HoneygramState honeygram;
  // final VoidCallback onWin;

  const HoneygramGame({
    super.key,
    required this.honeygram,
    // required this.onWin,
  });
  // Make the board Key so when the game changes State is dropped.
  // : super(key: ObjectKey(game));

  @override
  State<HoneygramGame> createState() => _HoneygramGameState();
  // _PangramGameState
}

class _HoneygramGameState extends State<HoneygramGame> {
  List<int> otherLettersOrder = List<int>.generate(6, (i) => i);

  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textController.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    final String text = textController.text.toUpperCase();
    textController.value = textController.value.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
      composing: TextRange.empty,
    );

    // TODO: Move the buttons into their own widgets that listen to the text controller.
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    textController.dispose();
    super.dispose();
  }

  void _handleLetterPressed(String letter) {
    textController.text += letter;
  }

  void _handleScamble() {
    setState(() {
      otherLettersOrder.shuffle();
    });
  }

  void _handleDelete() {
    textController.text =
        textController.text.substring(0, textController.text.length - 1);
  }

  String? _validateGuessedWord(String guessedWord) {
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

  // TODO: This likely belongs outside of this object.
  void _handleEnter() {
    setState(() {
      var guessedWord = textController.text.toLowerCase();
      textController.text = "";

      String? errorMessage = _validateGuessedWord(guessedWord);
      if (errorMessage != null) {
        final snackBar = SnackBar(content: Text(errorMessage));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      // widget.game.foundWord(guessedWord);
      context.read<HoneygramBloc>().add(
            FoundWord(
              word: guessedWord,
            ),
          );
    });

    // TODO: prob remove?
    // if (widget.game.haveWon) {
    // if (context.read<HoneygramBloc>().state.status == HoneygramStatus.hasWon) {
    //   widget.onWin();
    // }
  }

  List<String> scrambledOtherLetters() {
    List<String> otherLetters = widget.honeygram.board.otherLetters;
    List<String> scrambledLetters = <String>[];
    for (int i = 0; i < otherLetters.length; i++) {
      scrambledLetters.add(otherLetters[otherLettersOrder[i]]);
    }
    return scrambledLetters;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // FIXME: This sized box is a hack to make things not expand too wide.
      width: 350,
      child: Column(
        children: [
          const SizedBox(height: 25),
          HoneygramDifficulty(
            difficultyPercentile: widget.honeygram.board.difficultyPercentile,
          ),
          const SizedBox(height: 10),
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
            onEditingComplete: _handleEnter,
          ),
          const SizedBox(height: 20),
          HoneygramButtons(
            center: widget.honeygram.board.center,
            otherLetters: scrambledOtherLetters(),
            typeLetter: _handleLetterPressed,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: textController.text == "" ? null : _handleDelete,
                child: const Text("DELETE"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _handleScamble,
                child: const Text("SCRAMBLE"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: (textController.text == "" ||
                        widget.honeygram.status == HoneygramStatus.hasWon)
                    ? null
                    : _handleEnter,
                child: const Text("ENTER"),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
