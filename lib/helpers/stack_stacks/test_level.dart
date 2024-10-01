import 'package:corso_games_app/models/models.dart';

class TestLevel {
  StacksBrickStack brickStack1 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 0),
      StacksBrick(colorIndex: 0),
      StacksBrick(colorIndex: 1),
      StacksBrick(colorIndex: 1),
    ],
  );

  StacksBrickStack brickStack2 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 1),
      StacksBrick(colorIndex: 1),
      StacksBrick(colorIndex: 2),
      StacksBrick(colorIndex: 2),
    ],
  );

  StacksBrickStack brickStack3 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 2),
      StacksBrick(colorIndex: 2),
      StacksBrick(colorIndex: 3),
      StacksBrick(colorIndex: 3),
    ],
  );

  StacksBrickStack brickStack4 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 3),
      StacksBrick(colorIndex: 3),
      StacksBrick(colorIndex: 4),
      StacksBrick(colorIndex: 4),
    ],
  );

  StacksBrickStack brickStack5 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 4),
      StacksBrick(colorIndex: 4),
      StacksBrick(colorIndex: 5),
      StacksBrick(colorIndex: 5),
    ],
  );

  StacksBrickStack brickStack6 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 5),
      StacksBrick(colorIndex: 5),
      StacksBrick(colorIndex: 6),
      StacksBrick(colorIndex: 6),
    ],
  );

  StacksBrickStack brickStack7 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 6),
      StacksBrick(colorIndex: 6),
      StacksBrick(colorIndex: 7),
      StacksBrick(colorIndex: 7),
    ],
  );

  StacksBrickStack brickStack8 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 7),
      StacksBrick(colorIndex: 7),
      StacksBrick(colorIndex: 8),
      StacksBrick(colorIndex: 8),
    ],
  );

  StacksBrickStack brickStack9 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 8),
      StacksBrick(colorIndex: 8),
      StacksBrick(colorIndex: 9),
      StacksBrick(colorIndex: 9),
    ],
  );

  StacksBrickStack brickStack10 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 10),
      StacksBrick(colorIndex: 10),
      StacksBrick(colorIndex: 11),
      StacksBrick(colorIndex: 11),
    ],
  );

  StacksBrickStack brickStack11 = StacksBrickStack(
    bricks: [
      StacksBrick(colorIndex: 3),
      StacksBrick(colorIndex: 3),
      StacksBrick(colorIndex: 7),
      StacksBrick(colorIndex: 7),
    ],
  );

  StacksBrickStack brickStack12 = StacksBrickStack(bricks: []);

  StacksBrickStack brickStack13 = StacksBrickStack(bricks: []);

  List<StacksBrickStack> get stacksBrickStacks => [
        brickStack1,
        brickStack2,
        brickStack3,
        brickStack4,
        brickStack5,
        brickStack6,
        brickStack7,
        brickStack8,
        brickStack9,
        brickStack10,
        brickStack11,
        brickStack12,
        brickStack13,
      ];
}
