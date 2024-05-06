// Copyright 2020, the Flutter project authors.
// Please see https://github.com/kevmoo/slide_puzzle for details.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:corso_games_app/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart' show Ticker;

import 'package:corso_games_app/models/slide_to_slide/puzzle_animator.dart';
import 'package:corso_games_app/models/slide_to_slide/puzzle_proxy.dart';

class _PuzzleControls extends ChangeNotifier implements PuzzleControls {
  final PuzzleHomeState _parent;

  _PuzzleControls(this._parent);

  @override
  bool get autoPlay => _parent._autoPlay;

  void _notify() => notifyListeners();

  @override
  void Function(bool? newValue)? get setAutoPlayFunction {
    if (_parent.puzzle.solved) {
      return null;
    }
    return _parent._setAutoPlay;
  }

  @override
  int get clickCount => _parent.puzzle.clickCount;

  @override
  int get incorrectTiles => _parent.puzzle.incorrectTiles;

  @override
  void reset() => _parent.puzzle.reset();
}

class PuzzleHomeState extends State
    with SingleTickerProviderStateMixin, AppState {
  @override
  final PuzzleAnimator puzzle;

  @override
  final AnimationNotifier animationNotifier = AnimationNotifier();

  Duration _tickerTimeSinceLastEvent = Duration.zero;
  late Ticker _ticker;
  late Duration _lastElapsed;
  late StreamSubscription _puzzleEventSubscription;

  bool _autoPlay = false;
  late _PuzzleControls _autoPlayListenable;

  PuzzleHomeState(this.puzzle) {
    _puzzleEventSubscription = puzzle.onEvent.listen(_onPuzzleEvent);
  }

  @override
  void initState() {
    super.initState();
    _autoPlayListenable = _PuzzleControls(this);
    _ticker = createTicker(_onTick);
    _lastElapsed = Duration.zero;
    _ensureTicking();
  }

  void _setAutoPlay(bool? newValue) {
    if (newValue != _autoPlay) {
      setState(() {
        // Only allow enabling autoPlay if the puzzle is not solved
        _autoPlayListenable._notify();
        _autoPlay = newValue! && !puzzle.solved;
        if (_autoPlay) {
          _ensureTicking();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<AppState>.value(value: this),
          ListenableProvider<PuzzleControls>.value(
            value: _autoPlayListenable,
          )
        ],
        child: const Material(
          child: Stack(
            children: <Widget>[
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image(
                    image:
                        // AssetImage('assets/images/slide_to_slide/seattle.jpg'),
                        // AssetImage('assets/images/slide_to_slide/lure.jpg'),
                        AssetImage('assets/images/slide_to_slide/space.jpg'),
                  ),
                ),
              ),
              LayoutBuilder(builder: _doBuild),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    animationNotifier.dispose();
    _ticker.dispose();
    _autoPlayListenable.dispose();
    _puzzleEventSubscription.cancel();
    super.dispose();
  }

  void _onPuzzleEvent(PuzzleEvent e) {
    _autoPlayListenable._notify();
    if (e != PuzzleEvent.random) {
      _setAutoPlay(false);
    }
    _tickerTimeSinceLastEvent = Duration.zero;
    _ensureTicking();
    setState(() {
      // noop
    });
  }

  void _ensureTicking() {
    if (!_ticker.isTicking) {
      _ticker.start();
    }
  }

  void _onTick(Duration elapsed) {
    if (elapsed == Duration.zero) {
      _lastElapsed = elapsed;
    }
    final delta = elapsed - _lastElapsed;
    _lastElapsed = elapsed;

    if (delta.inMilliseconds <= 0) {
      // `_delta` may be negative or zero if `elapsed` is zero (first tick)
      // or during a restart. Just ignore this case.
      return;
    }

    _tickerTimeSinceLastEvent += delta;
    puzzle.update(delta > _maxFrameDuration ? _maxFrameDuration : delta);

    if (!puzzle.stable) {
      animationNotifier.animate();
    } else {
      if (!_autoPlay) {
        _ticker.stop();
        _lastElapsed = Duration.zero;
      }
    }

    if (_autoPlay &&
        _tickerTimeSinceLastEvent > const Duration(milliseconds: 200)) {
      puzzle.playRandom();

      if (puzzle.solved) {
        _setAutoPlay(false);
      }
    }
  }
}

class AnimationNotifier extends ChangeNotifier {
  void animate() {
    notifyListeners();
  }
}

const _maxFrameDuration = Duration(milliseconds: 34);

Widget _updateConstraints(
    BoxConstraints constraints, Widget Function(bool small) builder) {
  const smallWidth = 580;

  final constraintWidth =
      constraints.hasBoundedWidth ? constraints.maxWidth : 1000.0;

  final constraintHeight =
      constraints.hasBoundedHeight ? constraints.maxHeight : 1000.0;

  return builder(constraintWidth < smallWidth || constraintHeight < 690);
}

Widget _doBuild(BuildContext _, BoxConstraints constraints) =>
    _updateConstraints(constraints, _doBuildCore);

Widget _doBuildCore(bool small) => ValueTabController<SharedTheme>(
      values: themes,
      child: Consumer<SharedTheme>(
        builder: (_, theme, __) => AnimatedContainer(
          duration: puzzleAnimationDuration,
          color: theme.puzzleThemeBackground,
          child: Center(
            child: theme.styledWrapper(
              small,
              SizedBox(
                width: 580,
                child: Consumer<AppState>(
                  builder: (context, appState, _) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1,
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          controller: ValueTabController.of(context),
                          labelPadding: const EdgeInsets.fromLTRB(0, 20, 0, 12),
                          labelColor: theme.puzzleAccentColor,
                          indicatorColor: theme.puzzleAccentColor,
                          indicatorWeight: 1.5,
                          unselectedLabelColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.666),
                          tabs: themes
                              .map((st) => Text(
                                    st.name.toUpperCase(),
                                    style: const TextStyle(
                                      letterSpacing: 0.5,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Flow(
                            delegate: PuzzleFlowDelegate(
                              small ? const Size(90, 90) : const Size(140, 140),
                              appState.puzzle,
                              appState.animationNotifier,
                            ),
                            children: List<Widget>.generate(
                              appState.puzzle.length,
                              (i) => theme.tileButtonCore(
                                i,
                                appState.puzzle,
                                small,
                                context,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              // color: Colors.black26,
                              color: Theme.of(context).colorScheme.secondary,
                              width: 1,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          left: 10,
                          bottom: 6,
                          top: 2,
                          right: 10,
                        ),
                        child: Consumer<PuzzleControls>(
                          builder: (_, controls, __) => Row(
                            children: theme.bottomControls(
                              controls,
                              context,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
