// Copyright 2020, the Flutter project authors.
// Please see https://github.com/kevmoo/slide_puzzle for details.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:corso_games_app/models/slide_to_slide/puzzle_proxy.dart';

import 'package:corso_games_app/helpers/slide_to_slide/puzzle_controls.dart';
import 'package:corso_games_app/widgets/slide_to_slide/material_interior_alt.dart';

final puzzleAnimationDuration = kThemeAnimationDuration * 3;

abstract class SharedTheme {
  const SharedTheme();

  String get name;

  Color get puzzleThemeBackground;

  RoundedRectangleBorder puzzleBorder(bool small);

  Color get puzzleBackgroundColor;

  Color get puzzleAccentColor;

  EdgeInsetsGeometry tilePadding(PuzzleProxy puzzle) => const EdgeInsets.all(6);

  Widget tileButton(
    int i,
    PuzzleProxy puzzle,
    bool small,
    BuildContext context,
  );

  Ink createInk(
    Widget child, {
    DecorationImage? image,
    EdgeInsetsGeometry? padding,
  }) =>
      Ink(
        padding: padding,
        decoration: BoxDecoration(
          image: image,
        ),
        child: child,
      );

  Widget createButton(
    PuzzleProxy puzzle,
    bool small,
    int tileValue,
    Widget content, {
    Color? color,
    RoundedRectangleBorder? shape,
  }) =>
      AnimatedContainer(
        duration: puzzleAnimationDuration,
        padding: tilePadding(puzzle),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            animationDuration: puzzleAnimationDuration,
            shape: shape ?? puzzleBorder(small),
            padding: const EdgeInsets.symmetric(),
            backgroundColor: color,
          ),
          clipBehavior: Clip.hardEdge,
          onPressed: () => puzzle.clickOrShake(tileValue),
          child: content,
        ),
      );

  // Thought about using AnimatedContainer here, but it causes some weird
  // resizing behavior
  Widget styledWrapper(bool small, Widget child) => MaterialInterior(
        duration: puzzleAnimationDuration,
        shape: puzzleBorder(small),
        color: puzzleBackgroundColor,
        child: child,
      );

  TextStyle get _infoStyle => TextStyle(
        color: puzzleAccentColor,
        fontWeight: FontWeight.bold,
      );

  List<Widget> bottomControls(
    PuzzleControls controls,
    BuildContext context,
  ) =>
      <Widget>[
        Tooltip(
          message: 'Reset',
          child: IconButton(
            onPressed: controls.reset,
            icon: Icon(
              Icons.refresh,
              color: puzzleAccentColor,
            ),
          ),
        ),
        Tooltip(
          message: 'Auto play',
          child: Checkbox(
            value: controls.autoPlay,
            onChanged: controls.setAutoPlayFunction,
            activeColor: puzzleAccentColor,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: controls.clickCount.toString(),
                style: _infoStyle,
              ),
              // const TextSpan(text: ' Moves'),
              TextSpan(
                text: ' Moves',
                style: TextStyle(
                  // color: Colors.black,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 90,
          child: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              children: [
                TextSpan(
                  text: controls.incorrectTiles.toString(),
                  style: _infoStyle,
                ),
                TextSpan(
                  text: ' Tiles left',
                  style: TextStyle(
                    // color: Colors.black,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  Widget tileButtonCore(
    int i,
    PuzzleProxy puzzle,
    bool small,
    BuildContext context,
  ) {
    if (i == puzzle.tileCount && !puzzle.solved) {
      return const Center();
    }

    return tileButton(
      i,
      puzzle,
      small,
      context,
    );
  }
}
