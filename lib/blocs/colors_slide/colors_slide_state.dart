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
  final Map<Point, GamePiece> indexes;

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
    this.indexes = const {},
  });

  factory ColorsSlideState.fromJson(Map<String, dynamic> json) {
    print('fromJson');
    print(json);
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
          gridSize: model[0],
          position: Point(
            point[0],
            point[1],
          ),
          value: model[2],
        ),
        gridSize: pList[i][0],
      );
    }

    print('list of pieces (# only really)');
    print(piecesList);

    // Get index map from JSON
    var iList = json['indexes'] as Map;
    // Create empty Map for the index
    Map<Point, GamePiece> indexMap = {};

    print('water');
    print('resetColors: ${json['resetColors']}');
    print('showTimer: ${json['showTimer']}');
    print('difficulty: ${json['difficulty']}');
    print('lastDirection: ${json['lastDirection']}');
    print('status: ${json['status']}');
    print('score: ${json['score']}');
    print('size: ${json['size']}');
    print('timerSeconds: ${json['timerSeconds']}');
    print('piecesList: ${json['piecesList']}');
    print('indexes: ${json['indexes']}');
    print(iList);
    print(jsonDecode(json['indexes']));

    // Loop thru JSON map and store in Map of index
    // for (int i = 0; i < iList.length; i++) {
    //   // Expand the map with an empty index
    //   // indexMap.add

    //   // indexMap.add(
    //   //   GamePiece(
    //   //     model: GamePieceModel(
    //   //       gridSize: 0,
    //   //       position: const Point(0, 0),
    //   //       value: 0,
    //   //     ),
    //   //     gridSize: 0,
    //   //   ),
    //   // );

    //   // Cache model & point
    //   var model = iList[i][1];
    //   var point = model[1];

    //   // Fill out list item
    //   piecesList[i] = GamePiece(
    //     model: GamePieceModel(
    //       gridSize: model[0],
    //       position: Point(
    //         point[0],
    //         point[1],
    //       ),
    //       value: model[2],
    //     ),
    //     gridSize: iList[i][0],
    //   );
    // }

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
      // pieces: piecesList,
      // TODO
      // pieces: json['pieces'],
      pieces: piecesList,
      // index: json['index'],
      indexes: indexMap,
    );
  }

  Map<String, dynamic> toJson() {
    print('toJson');
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

    print('pieces count: ${piecesList.length}');

    // Create an empty map for the index
    var indexMap = {};
    print('index count: ${indexes.length}');
    indexMap.addAll(indexes);
    print('indexMap count: ${indexMap.length}');
    print(indexMap);

    // Loop thru the pieces in state to store in JSON
    // for (int i = 0; i < index.length; i++) {
    //   // Add an empty entry to the pieces list
    //   indexMap.add('');
    //   indexMap.addAll(index);
    //   // indexMap.addEntries(index);

    //   // Enter the pieces data
    //   piecesList[i] = [
    //     size,
    //     [
    //       pieces[i].model.value,
    //       [
    //         pieces[i].model.position.x,
    //         pieces[i].model.position.y,
    //       ],
    //       pieces[i].model.gridSize,
    //     ],
    //   ];
    // }

    print('g2g');

    var derp = {
      'resetColors': resetColors,
      'showTimer': showTimer,
      'difficulty': difficulty.name,
      'lastDirection': lastDirection.name,
      'status': status.name,
      'score': score,
      'size': size,
      'timerSeconds': timerSeconds,
      'pieces': piecesList,
      'indexes': indexMap,
    };

    print(derp);
    return derp;
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
        indexes,
      ];
}
