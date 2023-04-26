part of 'colors_slide_bloc.dart';

enum ColorsSlideDifficulty {
  tbd,
  threeByThree,
  fourByFour,
  fiveByFive,
  sevenBySeven,
  tenByTen,
  yolo,
}

enum ColorsSlideDirection {
  up,
  down,
  left,
  right,
  none,
}

enum ColorsSlideStatus {
  loading,
  loaded,
  gameOver,
  error,
}

class ColorsSlideState extends Equatable {
  final bool resetColors;
  // final bool showColorsTimer;
  final ColorsSlideDifficulty colorsDifficulty;
  final ColorsSlideDirection colorsLastDirection;
  final ColorsSlideStatus colorsStatus;
  final int colorsScore;
  final int colorsSize;
  // final int colorsTimerSeconds;
  final List<ColorsGamePiece> colorsPieces;
  final Map<Point, ColorsGamePiece> colorsIndexMap;

  const ColorsSlideState({
    this.resetColors = false,
    // this.showColorsTimer = false,
    this.colorsDifficulty = ColorsSlideDifficulty.threeByThree,
    this.colorsLastDirection = ColorsSlideDirection.right,
    this.colorsStatus = ColorsSlideStatus.loading,
    this.colorsScore = 0,
    this.colorsSize = 3,
    // this.colorsTimerSeconds = 0,
    this.colorsPieces = const [],
    this.colorsIndexMap = const {},
  });

  factory ColorsSlideState.fromJson(Map<String, dynamic> json) {
    // print('fromJson');
    // Get colorsPieces list from JSON
    var pList = json['colorsPieces'] as List;
    // Create empty List of GamePieces
    List<ColorsGamePiece> colorsPiecesList = [];

    // Loop thru JSON list and store in List of GamePieces
    for (int i = 0; i < pList.length; i++) {
      // Expand the array with an empty GamePiece
      colorsPiecesList.add(
        ColorsGamePiece(
          model: ColorsGamePieceModel(
            gridSize: 0,
            position: const Point(0, 0),
            value: 0,
          ),
          gridSize: 0,
        ),
      );

      // Cache model & point
      var model = pList[i][1];
      var point = model[1];

      // Fill out list item
      colorsPiecesList[i] = ColorsGamePiece(
        model: ColorsGamePieceModel(
          value: model[0],
          position: Point(
            point[0],
            point[1],
          ),
          gridSize: model[2],
        ),
        gridSize: pList[i][0],
      );
    }

    // Get index map from JSON
    var iMap = json['colorsIndexMap'] as Map;

    // Create empty Map for the index
    Map<Point, ColorsGamePiece> tempIndexMap = {};

    // Loop thru JSON map and store in Map of index
    iMap.forEach((key, value) {
      var point = key.toString();
      var px = point.substring(point.indexOf('(') + 1, point.indexOf(','));
      var py = point.substring(point.indexOf(' ') + 1, point.indexOf(')'));
      var model = value['model'];
      var position = model['position'];
      tempIndexMap.addAll({
        Point(
          int.parse(px),
          int.parse(py),
        ): ColorsGamePiece(
          gridSize: value['gridSize'],
          model: ColorsGamePieceModel(
            gridSize: model['gridSize'],
            position: Point(
              position['x'],
              position['y'],
            ),
            value: model['value'],
          ),
        ),
      });
    });

    return ColorsSlideState(
      resetColors: json['resetColors'],
      // showColorsTimer: json['showColorsTimer'],
      colorsDifficulty: ColorsSlideDifficulty.values.firstWhere(
        (diff) => diff.name.toString() == json['colorsDifficulty'],
      ),
      colorsLastDirection: ColorsSlideDirection.values.firstWhere(
        (direction) => direction.name.toString() == json['colorsLastDirection'],
      ),
      colorsStatus: ColorsSlideStatus.values.firstWhere(
        (colorsStatus) => colorsStatus.name.toString() == json['colorsStatus'],
      ),
      colorsScore: json['colorsScore'],
      colorsSize: json['colorsSize'],
      // colorsTimerSeconds: json['colorsTimerSeconds'],
      colorsPieces: colorsPiecesList,
      colorsIndexMap: tempIndexMap,
    );
  }

  Map<String, dynamic> toJson() {
    // print('toJson');
    // Create an empty list for the colorsPieces
    var colorsPiecesList = [];

    // Loop thru the colorsPieces in state to store in JSON
    for (int i = 0; i < colorsPieces.length; i++) {
      // Add an empty entry to the colorsPieces list
      colorsPiecesList.add('');

      // Enter the colorsPieces data
      colorsPiecesList[i] = [
        colorsSize,
        [
          colorsPieces[i].model.value,
          [
            colorsPieces[i].model.position.x,
            colorsPieces[i].model.position.y,
          ],
          colorsPieces[i].model.gridSize,
        ],
      ];
    }

    // Create an empty map for the index
    Map<dynamic, dynamic> tempIndexMap = {};

    colorsIndexMap.forEach((key, value) {
      var point = key;
      var gp = value;
      tempIndexMap['(${point.x}, ${point.y})'] = {
        'gridSize': gp.gridSize,
        'model': {
          'value': gp.model.value,
          'position': {
            'x': gp.model.position.x,
            'y': gp.model.position.y,
          },
          'gridSize': gp.model.gridSize,
        },
      };
    });

    return {
      'resetColors': resetColors,
      // 'showColorsTimer': showColorsTimer,
      'colorsDifficulty': colorsDifficulty.name,
      'colorsLastDirection': colorsLastDirection.name,
      'colorsStatus': colorsStatus.name,
      'colorsScore': colorsScore,
      'colorsSize': colorsSize,
      // 'colorsTimerSeconds': colorsTimerSeconds,
      'colorsPieces': colorsPiecesList,
      'colorsIndexMap': tempIndexMap,
    };
  }

  @override
  List<Object> get props => [
        resetColors,
        // showColorsTimer,
        colorsDifficulty,
        colorsStatus,
        colorsScore,
        colorsSize,
        // colorsTimerSeconds,
        colorsPieces,
        colorsIndexMap,
      ];
}
