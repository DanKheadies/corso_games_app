// Copyright 2020, the Flutter project authors.
// Please see https://github.com/kevmoo/slide_puzzle for details.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:corso_games_app/helpers/slide_to_slide/shared_theme.dart';
import 'package:corso_games_app/models/slide_to_slide/puzzle_proxy.dart';

// const _accentBlue = Color(0xff000579);
const _primary = Color.fromARGB(255, 192, 65, 111);
const _secondary = Color(0xFFFFF8E1);
const _tertiary = Color.fromARGB(255, 245, 125, 129);

class ThemeSimple extends SharedTheme {
  @override
  String get name => 'Simple';

  const ThemeSimple();

  @override
  Color get puzzleThemeBackground => _secondary;

  @override
  Color get puzzleBackgroundColor => Colors.white70;

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
  Widget tileButton(int i, PuzzleProxy puzzle, bool small) {
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
