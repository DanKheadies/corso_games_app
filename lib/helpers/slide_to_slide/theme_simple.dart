// Copyright 2020, the Flutter project authors.
// Please see https://github.com/kevmoo/slide_puzzle for details.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:flutter/material.dart';

// const _accentBlue = Color(0xff000579);
final darkMode = WidgetsBinding.instance.window.platformBrightness;
const _primary = Color(0xFFc0416f);
final _secondary = darkMode == Brightness.dark
    ? const Color(0xFF1a1a1a)
    : const Color(0xFFfff8e1);
final _tertiary = darkMode == Brightness.dark
    ? const Color(0xFFb3585a)
    : const Color(0xFFff7d81);
final _boardBackground = darkMode == Brightness.dark
    ? const Color(0xFF0b0b0b)
    : const Color(0xFFf9f9f9);

class ThemeSimple extends SharedTheme {
  @override
  String get name => 'Simple';

  ThemeSimple();

  @override
  Color get puzzleThemeBackground => _secondary;

  @override
  Color get puzzleBackgroundColor => _boardBackground;

  @override
  Color get puzzleAccentColor => _tertiary;

  @override
  RoundedRectangleBorder puzzleBorder(bool small) =>
      const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black26, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      );

  @override
  Widget tileButton(
    int i,
    PuzzleProxy puzzle,
    bool small,
    BuildContext context,
  ) {
    if (i == puzzle.tileCount) {
      assert(puzzle.solved);
      return const Center(
        child: Icon(
          Icons.thumb_up,
          size: 72,
          color: _primary,
        ),
      );
    }

    final correctPosition = puzzle.isCorrectPosition(i);

    final content = createInk(
      Center(
        child: Text(
          (i + 1).toString(),
          style: TextStyle(
            color: _secondary,
            fontWeight: correctPosition ? FontWeight.bold : FontWeight.normal,
            fontSize: small ? 30 : 49,
          ),
        ),
      ),
    );

    return createButton(
      puzzle,
      small,
      i,
      content,
      color: _tertiary,
    );
  }
}
