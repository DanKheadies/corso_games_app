// Copyright 2020, the Flutter project authors.
// Please see https://github.com/kevmoo/slide_puzzle for details.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/helpers/helpers.dart';

class PuzzleScreen extends StatelessWidget {
  final int rows, columns;

  const PuzzleScreen({
    Key? key,
    this.columns = 4,
    this.rows = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _PuzzleHome(rows, columns);
}

class _PuzzleHome extends StatefulWidget {
  final int _rows, _columns;

  const _PuzzleHome(this._rows, this._columns);

  @override
  PuzzleHomeState createState() =>
      PuzzleHomeState(PuzzleAnimator(_columns, _rows));
}
