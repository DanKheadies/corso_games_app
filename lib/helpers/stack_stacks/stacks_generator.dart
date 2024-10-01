import 'package:corso_games_app/models/models.dart';

class StacksGenerator {
  List<StacksBrickStack> generateLevel({
    int totalStacks = 11,
    int bricksPerStack = 4,
  }) {
    List<int> temp = List.generate(
      totalStacks * bricksPerStack,
      (index) => (index ~/ bricksPerStack) + 1,
    );
    temp.shuffle();
    List<List<int>> chunks = [];
    for (var i = 0; i < temp.length; i += bricksPerStack) {
      chunks.add(temp.skip(i).take(bricksPerStack).toList());
    }

    return [
      ...chunks.map(
        (chunk) => StacksBrickStack(
          bricks: List.generate(
            chunk.length,
            (index) => StacksBrick(
              colorIndex: chunk[index],
            ),
          ),
        ),
      ),
      StacksBrickStack(bricks: []),
      StacksBrickStack(bricks: []),
    ];
  }
}
