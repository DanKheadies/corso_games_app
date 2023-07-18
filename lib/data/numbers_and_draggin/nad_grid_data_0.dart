import 'package:corso_games_app/models/models.dart';

List<NadGridUnit> nadGridData0(
  double squareSize,
  double boardPad,
  int columns,
  int rows,
  String activeColor,
) {
  // print('daco');
  List<int> dynamicList = List.generate(30, (index) => index)..shuffle();
  // print(dynamicList);

  List<NadGridUnit> nadGrid = [];

  for (int value in dynamicList) {
    // print('value # $value');
    // print('index # ${dynamicList.indexOf(value)}');
    // print('left # ${dynamicList.indexOf(value) % rows}');
    // print('top # ${(dynamicList.indexOf(value) / rows).floor()}');
    // print(squareSize);
    // print(boardPad);
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
  // print(nadGrid.length);

  return nadGrid;
}

// NadGridUnit(
//   id: '1',
//   data: 'green',
//   left: (squareSize * 0) + (boardPad * 0),
//   top: (squareSize * 0) + (boardPad * 0),
// ),
// NadGridUnit(
//   id: '2',
//   left: (squareSize * 1) + (boardPad * 1),
//   top: (squareSize * 0) + (boardPad * 0),
// ),
// NadGridUnit(
//   id: '3',
//   left: (squareSize * 2) + (boardPad * 2),
//   top: (squareSize * 0) + (boardPad * 0),
// ),
// NadGridUnit(
//   id: '4',
//   left: (squareSize * 3) + (boardPad * 3),
//   top: (squareSize * 0) + (boardPad * 0),
// ),
// NadGridUnit(
//   id: '5',
//   left: (squareSize * 4) + (boardPad * 4),
//   top: (squareSize * 0) + (boardPad * 0),
// ),
// NadGridUnit(
//   id: '6',
//   left: (squareSize * 5) + (boardPad * 5),
//   top: (squareSize * 0) + (boardPad * 0),
// ),
// NadGridUnit(
//   id: '7',
//   left: (squareSize * 0) + (boardPad * 0),
//   top: (squareSize * 1) + (boardPad * 1),
// ),
// NadGridUnit(
//   id: '8',
//   left: (squareSize * 1) + (boardPad * 1),
//   top: (squareSize * 1) + (boardPad * 1),
// ),
// NadGridUnit(
//   id: '9',
//   left: (squareSize * 2) + (boardPad * 2),
//   top: (squareSize * 1) + (boardPad * 1),
// ),
// NadGridUnit(
//   id: '10',
//   left: (squareSize * 3) + (boardPad * 3),
//   top: (squareSize * 1) + (boardPad * 1),
// ),
// NadGridUnit(
//   id: '11',
//   left: (squareSize * 4) + (boardPad * 4),
//   top: (squareSize * 1) + (boardPad * 1),
// ),
// NadGridUnit(
//   id: '12',
//   left: (squareSize * 5) + (boardPad * 5),
//   top: (squareSize * 1) + (boardPad * 1),
// ),
// NadGridUnit(
//   id: '13',
//   left: (squareSize * 0) + (boardPad * 0),
//   top: (squareSize * 2) + (boardPad * 2),
// ),
// NadGridUnit(
//   id: '14',
//   left: (squareSize * 1) + (boardPad * 1),
//   top: (squareSize * 2) + (boardPad * 2),
// ),
// NadGridUnit(
//   id: '15',
//   left: (squareSize * 2) + (boardPad * 2),
//   top: (squareSize * 2) + (boardPad * 2),
// ),
// NadGridUnit(
//   id: '16',
//   left: (squareSize * 3) + (boardPad * 3),
//   top: (squareSize * 2) + (boardPad * 2),
// ),
// NadGridUnit(
//   id: '17',
//   left: (squareSize * 4) + (boardPad * 4),
//   top: (squareSize * 2) + (boardPad * 2),
// ),
// NadGridUnit(
//   id: '18',
//   left: (squareSize * 5) + (boardPad * 5),
//   top: (squareSize * 2) + (boardPad * 2),
// ),
// NadGridUnit(
//   id: '19',
//   left: (squareSize * 0) + (boardPad * 0),
//   top: (squareSize * 3) + (boardPad * 3),
// ),
// NadGridUnit(
//   id: '20',
//   left: (squareSize * 1) + (boardPad * 1),
//   top: (squareSize * 3) + (boardPad * 3),
// ),
// NadGridUnit(
//   id: '21',
//   left: (squareSize * 2) + (boardPad * 2),
//   top: (squareSize * 3) + (boardPad * 3),
// ),
// NadGridUnit(
//   id: '22',
//   left: (squareSize * 3) + (boardPad * 3),
//   top: (squareSize * 3) + (boardPad * 3),
// ),
// NadGridUnit(
//   id: '23',
//   left: (squareSize * 4) + (boardPad * 4),
//   top: (squareSize * 3) + (boardPad * 3),
// ),
// NadGridUnit(
//   id: '24',
//   left: (squareSize * 5) + (boardPad * 5),
//   top: (squareSize * 3) + (boardPad * 3),
// ),
// NadGridUnit(
//   id: '25',
//   left: (squareSize * 0) + (boardPad * 0),
//   top: (squareSize * 4) + (boardPad * 4),
// ),
// NadGridUnit(
//   id: '26',
//   left: (squareSize * 1) + (boardPad * 1),
//   top: (squareSize * 4) + (boardPad * 4),
// ),
// NadGridUnit(
//   id: '27',
//   left: (squareSize * 2) + (boardPad * 2),
//   top: (squareSize * 4) + (boardPad * 4),
// ),
// NadGridUnit(
//   id: '28',
//   left: (squareSize * 3) + (boardPad * 3),
//   top: (squareSize * 4) + (boardPad * 4),
// ),
// NadGridUnit(
//   id: '29',
//   left: (squareSize * 4) + (boardPad * 4),
//   top: (squareSize * 4) + (boardPad * 4),
// ),
