import 'package:corso_games_app/helpers/helpers.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StackStacksProvider extends ChangeNotifier {
  late List<StacksBrickStack> brickStacks;
  int stackIndex = -1;
  bool hasWon = false;
  bool hasLost = false;

  StackStacksProvider() {
    // brickStacks = TestLevel().stacksBrickStacks;
    brickStacks = StacksGenerator().generateLevel();
  }

  void resetGame() {
    brickStacks = StacksGenerator().generateLevel();
    stackIndex = -1;
    hasWon = false;
    hasLost = false;
    notifyListeners();
  }

  void setIndex(int index) {
    stackIndex = index;
    notifyListeners();
  }

  List<StacksStackWidget> createBrickStackWidgetList(
    BuildContext context,
    double height,
  ) {
    return List.generate(
      brickStacks.length,
      (stackIndex) => StacksStackWidget(
        index: stackIndex,
        height: height,
        bricks: List.generate(
          brickStacks[stackIndex].bricks.length,
          (brickIndex) => StacksBrickWidget(
            colorIndex: brickStacks[stackIndex].bricks[brickIndex].colorIndex,
            height: height,
          ),
        ),
        onTap: () => _handleTap(context, stackIndex),
      ),
    );
  }

  void _handleTap(BuildContext context, int currentStackIndex) {
    if (!hasWon && !hasLost) {
      if (stackIndex == currentStackIndex) {
        setIndex(-1);
      } else {
        if (stackIndex == -1) {
          setIndex(currentStackIndex);
        } else {
          performAction(
              giverIndex: stackIndex, receiverIndex: currentStackIndex);
          setIndex(-1);
        }
      }
    }

    if (hasWon || hasLost) {
      StacksGameDialog.openStacksGameDialog(context, hasWon, resetGame);
    }
  }

  void performAction({
    required int giverIndex,
    required int receiverIndex,
  }) {
    StacksBrickStack giver = brickStacks[giverIndex];
    StacksBrickStack receiver = brickStacks[receiverIndex];

    if (_legalMove(giver: giver, receiver: receiver)) {
      receiver.push(giver.pop());
      _checkForWin();
      _checkForLose();
      notifyListeners();
    }
  }

  bool _legalMove({
    required StacksBrickStack giver,
    required StacksBrickStack receiver,
  }) {
    return receiver.isEmpty ||
        (giver != receiver &&
            !giver.isEmpty &&
            giver.bricks.last.colorIndex == receiver.bricks.last.colorIndex &&
            giver.lastElementSize() + receiver.bricks.length < 5);
  }

  void _checkForWin() {
    hasWon = true;

    for (StacksBrickStack brickStack in brickStacks) {
      if (!brickStack.isEmpty) {
        if (brickStack.bricks.length < 4) {
          hasWon = false;
          break;
        }
        int colorIndex = brickStack.bricks.first.colorIndex;
        for (StacksBrick brick in brickStack.bricks) {
          if (colorIndex != brick.colorIndex) {
            hasWon = false;
            break;
          }
        }
      }
      if (!hasWon) {
        break;
      }
    }
  }

  void _checkForLose() {
    hasLost = true;

    for (StacksBrickStack giver in brickStacks) {
      for (StacksBrickStack receiver in brickStacks) {
        if (_legalMove(giver: giver, receiver: receiver)) {
          hasLost = false;
          break;
        }
      }
      if (!hasLost) {
        break;
      }
    }
  }
}
