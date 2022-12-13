import 'package:corso_games_app/models/models.dart';

List<GridUnit> grid1(
  double posLeft,
  double posTop,
  double squareSize,
  double boardPad,
) {
  List<GridUnit> grid = [];
  grid = [
    GridUnit(
      id: '1',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '2',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '3',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '4',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '5',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '6',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '7',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '8',
      data: 'white',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '9',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '10',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '11',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '12',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '13',
      data: 'white',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '14',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '15',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '16',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '17',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '18',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '19',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '20',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '21',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '22',
      data: 'white',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '23',
      data: 'white',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '24',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '25',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '26',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '27',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '28',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '29',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '30',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
  ];
  return grid;
}
