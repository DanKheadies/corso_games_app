import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HoneygramButtons extends StatelessWidget {
  final String center;
  final List<String> otherLetters;
  final ValueChanged<String> typeLetter;

  const HoneygramButtons({
    super.key,
    required this.center,
    required this.otherLetters,
    required this.typeLetter,
  });

  @override
  Widget build(BuildContext context) {
    var children = [
      LayoutId(
        id: HoneygramSlot.center,
        child: HoneygramTile(
          letter: center,
          onPressed: typeLetter,
          isCenter: true,
        ),
      ),
    ];
    for (var i = 0; i < otherLetters.length; ++i) {
      var letter = otherLetters[i];
      children.add(
        LayoutId(
          id: HoneygramSlot.values[i + 1],
          child: HoneygramTile(
            letter: letter,
            onPressed: typeLetter,
            isCenter: false,
          ),
        ),
      );
    }
    return CustomMultiChildLayout(
      delegate: HoneygramLayoutDelegate(),
      children: children,
    );
  }
}
