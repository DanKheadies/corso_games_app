import 'package:corso_games_app/models/models.dart';

class StacksBrickStack {
  final List<StacksBrick> bricks;

  const StacksBrickStack({
    required this.bricks,
  });

  void push(List<StacksBrick> newBricks) => bricks.addAll(newBricks);

  List<StacksBrick> pop() {
    List<StacksBrick> oldBricks = [];
    for (StacksBrick brick in [...bricks.reversed]) {
      if (oldBricks.isEmpty || brick.colorIndex == oldBricks.last.colorIndex) {
        oldBricks.add(bricks.removeLast());
      } else {
        break;
      }
    }

    return oldBricks;
  }

  int lastElementSize() {
    List<StacksBrick> lastBricks = [];
    for (StacksBrick brick in bricks.reversed) {
      if (lastBricks.isEmpty ||
          brick.colorIndex == lastBricks.last.colorIndex) {
        lastBricks.add(brick);
      } else {
        break;
      }
    }
    return lastBricks.length;
  }

  bool get isEmpty => bricks.isEmpty;

  @override
  String toString() => bricks.map((brick) => brick.toString()).join('\n');
}
