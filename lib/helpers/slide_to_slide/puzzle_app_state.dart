// Copyright 2020, the Flutter project authors.
// Please see https://github.com/kevmoo/slide_puzzle for details.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:corso_games_app/models/models.dart';
import 'package:flutter/foundation.dart';

abstract class PuzzleAppState {
  PuzzleProxy get puzzle;

  Listenable get animationNotifier;
}
