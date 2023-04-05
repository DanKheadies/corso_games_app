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
  final bool showTimer;
  final ColorsSlideDifficulty difficulty;
  final ColorsSlideDirection lastDirection;
  final ColorsSlideStatus status;
  final int score;
  final int size;
  final int timerSeconds;
  final List<GamePiece> pieces;
  final Map<Point, GamePiece> indexMap;

  const ColorsSlideState({
    this.resetColors = false,
    this.showTimer = false,
    this.difficulty = ColorsSlideDifficulty.threeByThree,
    this.lastDirection = ColorsSlideDirection.right,
    this.status = ColorsSlideStatus.loading,
    this.score = 0,
    this.size = 3,
    this.timerSeconds = 0,
    this.pieces = const [],
    this.indexMap = const {},
  });

  factory ColorsSlideState.fromJson(Map<String, dynamic> json) {
    // print('fromJson');
    // Get pieces list from JSON
    var pList = json['pieces'] as List;
    // Create empty List of GamePieces
    List<GamePiece> piecesList = [];

    // Loop thru JSON list and store in List of GamePieces
    for (int i = 0; i < pList.length; i++) {
      // Expand the array with an empty GamePiece
      piecesList.add(
        GamePiece(
          model: GamePieceModel(
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
      piecesList[i] = GamePiece(
        model: GamePieceModel(
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
    var iMap = json['indexMap'] as Map;

    // Create empty Map for the index
    Map<Point, GamePiece> tempIndexMap = {};

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
        ): GamePiece(
          gridSize: value['gridSize'],
          model: GamePieceModel(
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

    // TODO: remove testing prints
    // piecesList.forEach((piece) {
    //   print(piece.model.position);
    // });
    // tempIndexMap.forEach((point, gamePiece) {
    //   print(point);
    // });

    return ColorsSlideState(
      resetColors: json['resetColors'],
      showTimer: json['showTimer'],
      difficulty: ColorsSlideDifficulty.values.firstWhere(
        (diff) => diff.name.toString() == json['difficulty'],
      ),
      lastDirection: ColorsSlideDirection.values.firstWhere(
        (direction) => direction.name.toString() == json['lastDirection'],
      ),
      status: ColorsSlideStatus.values.firstWhere(
        (status) => status.name.toString() == json['status'],
      ),
      score: json['score'],
      size: json['size'],
      timerSeconds: json['timerSeconds'],
      pieces: piecesList,
      indexMap: tempIndexMap,
    );
  }

  Map<String, dynamic> toJson() {
    // print('toJson');
    // Create an empty list for the pieces
    var piecesList = [];

    // Loop thru the pieces in state to store in JSON
    for (int i = 0; i < pieces.length; i++) {
      // Add an empty entry to the pieces list
      piecesList.add('');

      // Enter the pieces data
      piecesList[i] = [
        size,
        [
          pieces[i].model.value,
          [
            pieces[i].model.position.x,
            pieces[i].model.position.y,
          ],
          pieces[i].model.gridSize,
        ],
      ];
    }

    // Create an empty map for the index
    Map<dynamic, dynamic> tempIndexMap = {};

    indexMap.forEach((key, value) {
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

    // TODO: remove testing prints
    // piecesList.forEach((piece) {
    //   print(piece[1][1]);
    // });
    // tempIndexMap.forEach((point, gamePiece) {
    //   print(point);
    // });

    return {
      'resetColors': resetColors,
      'showTimer': showTimer,
      'difficulty': difficulty.name,
      'lastDirection': lastDirection.name,
      'status': status.name,
      'score': score,
      'size': size,
      'timerSeconds': timerSeconds,
      'pieces': piecesList,
      'indexMap': tempIndexMap,
    };
  }

  @override
  List<Object> get props => [
        resetColors,
        showTimer,
        difficulty,
        status,
        score,
        size,
        timerSeconds,
        pieces,
        indexMap,
      ];
}
