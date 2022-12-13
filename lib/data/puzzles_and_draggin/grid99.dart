import 'package:corso_games_app/models/models.dart';

List<GridUnit> grid99(
  double posLeft,
  double posTop,
  double squareSize,
  double boardPad,
) {
  List<GridUnit> grid = [];
  grid = [
    GridUnit(
      id: '1',
      data: 'pink',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '2',
      data: 'red',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '3',
      data: 'deepOrange',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '4',
      data: 'orange',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '5',
      data: 'amber',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '6',
      data: 'yellow',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 0) + (boardPad * 0),
    ),
    GridUnit(
      id: '7',
      data: 'lime',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '8',
      data: 'greenAccent',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '9',
      data: 'green',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '10',
      data: 'teal',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '11',
      data: 'cyan',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '12',
      data: 'lightBlue',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 1) + (boardPad * 1),
    ),
    GridUnit(
      id: '13',
      data: 'blueAccent',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '14',
      data: 'blue',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '15',
      data: 'blueGrey',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '16',
      data: 'indigo',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '17',
      data: 'indigoAccent',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '18',
      data: 'purple',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 2) + (boardPad * 2),
    ),
    GridUnit(
      id: '19',
      data: 'purpleAccent',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '20',
      data: 'deepPurple',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '21',
      data: 'deepPurpleAccent',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '22',
      data: 'brown',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '23',
      data: 'black',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '24',
      data: 'grey',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 3) + (boardPad * 3),
    ),
    GridUnit(
      id: '25',
      data: 'pinkAccent',
      left: posLeft + (squareSize * 0) + (boardPad * 0),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '26',
      data: 'redAccent',
      left: posLeft + (squareSize * 1) + (boardPad * 1),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '27',
      data: 'deepOrangeAccent',
      left: posLeft + (squareSize * 2) + (boardPad * 2),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '28',
      data: 'orangeAccent',
      left: posLeft + (squareSize * 3) + (boardPad * 3),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '29',
      data: 'amberAccent',
      left: posLeft + (squareSize * 4) + (boardPad * 4),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
    GridUnit(
      id: '30',
      data: 'yellowAccent',
      left: posLeft + (squareSize * 5) + (boardPad * 5),
      top: posTop + (squareSize * 4) + (boardPad * 4),
    ),
  ];
  return grid;
}
