import 'dart:math';

import 'package:flutter/material.dart';

enum HoneygramSlot {
  center,
  first,
  second,
  third,
  fourth,
  fifth,
  sixth,
}

class HoneygramLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    var centerSize = layoutChild(
      HoneygramSlot.center,
      BoxConstraints.loose(size),
    );
    positionChild(
      HoneygramSlot.center,
      size.center(Offset.zero) - centerSize.center(Offset.zero),
    );

    var radius = size.shortestSide / 3.0;
    const angleIncrement = pi / 3.0;
    const satelliteCount = 6;

    for (int i = 0; i < satelliteCount; ++i) {
      var slot = HoneygramSlot.values[i + 1]; // The center slot is index 0.
      var satelliteSize = layoutChild(slot, BoxConstraints.loose(size));
      var angle = i * angleIncrement + pi / 6.0;
      var satelliteOffset = size.center(Offset.zero) +
          Offset(cos(angle), sin(angle)) * radius -
          satelliteSize.center(Offset.zero);
      positionChild(slot, satelliteOffset);
    }
  }

  @override
  Size getSize(BoxConstraints constraints) => const Size(200, 200);

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
