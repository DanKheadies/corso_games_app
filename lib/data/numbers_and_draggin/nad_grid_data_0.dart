import 'package:corso_games_app/models/models.dart';

List<NadGridUnit> nadGridData0(
  double squareSize,
  double boardPad,
  int columns,
  int rows,
  String activeColor,
) {
  List<int> dynamicList = List.generate(30, (index) => index)..shuffle();

  List<NadGridUnit> nadGrid = [];

  for (int value in dynamicList) {
    nadGrid.add(
      NadGridUnit(
        id: value.toString(),
        data: value == 0 ? activeColor : null,
        left: (squareSize * (dynamicList.indexOf(value) % columns)) +
            (boardPad * (dynamicList.indexOf(value) % columns)),
        top: (squareSize * (dynamicList.indexOf(value) / columns).floor()) +
            (boardPad * (dynamicList.indexOf(value) / columns).floor()),
      ),
    );
  }

  return nadGrid;
}
