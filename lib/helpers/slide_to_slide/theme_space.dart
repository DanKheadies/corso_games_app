// Copyright 2020, the Flutter project authors.
// Please see https://github.com/kevmoo/slide_puzzle for details.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:corso_games_app/helpers/slide_to_slide/shared_theme.dart';
import 'package:corso_games_app/models/slide_to_slide/puzzle_proxy.dart';
import 'package:corso_games_app/widgets/slide_to_slide/decoration_image_plus.dart';

class ThemeSpace extends SharedTheme {
  @override
  String get name => 'Space';

  const ThemeSpace();

  @override
  Color get puzzleThemeBackground => const Color.fromARGB(153, 90, 135, 170);

  @override
  Color get puzzleBackgroundColor => Colors.white70;

  @override
  Color get puzzleAccentColor => const Color(0xFF000579);

  @override
  RoundedRectangleBorder puzzleBorder(bool small) =>
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(1),
        ),
      );

  @override
  EdgeInsetsGeometry tilePadding(PuzzleProxy puzzle) =>
      puzzle.solved ? const EdgeInsets.all(1) : const EdgeInsets.all(4);

  @override
  Widget tileButton(int i, PuzzleProxy puzzle, bool small) {
    if (i == puzzle.tileCount && !puzzle.solved) {
      assert(puzzle.solved);
    }

    final decorationImage = DecorationImagePlus(
      puzzleWidth: puzzle.width,
      puzzleHeight: puzzle.height,
      pieceIndex: i,
      fit: BoxFit.cover,
      image: const AssetImage('assets/images/slide_to_slide/space.jpg'),
    );

    final correctPosition = puzzle.isCorrectPosition(i);
    final content = createInk(
      puzzle.solved
          ? const Center()
          : Container(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: correctPosition ? Colors.black38 : Colors.white54,
              ),
              alignment: Alignment.center,
              child: Text(
                (i + 1).toString(),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: correctPosition ? Colors.white : Colors.black,
                  fontSize: small ? 25 : 42,
                ),
              ),
            ),
      image: decorationImage,
      padding: EdgeInsets.all(small ? 20 : 32),
    );

    return createButton(
      puzzle,
      small,
      i,
      content,
    );
  }
}
