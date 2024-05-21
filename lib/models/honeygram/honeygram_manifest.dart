// import 'package:corso_games_app/models/models.dart';
// import 'package:equatable/equatable.dart';
// import 'package:intl/intl.dart';

// class HoneygramManifest extends Equatable {
//   final int chunkSize;
//   final int totalBoards;
//   final List<HoneygramChunkHeader> chunkHeaders;
//   final String numberPattern;
//   final String prefix;
//   final String suffix;

//   const HoneygramManifest({
//     required this.chunkHeaders,
//     required this.chunkSize,
//     required this.numberPattern,
//     required this.prefix,
//     required this.suffix,
//     required this.totalBoards,
//   });

//   @override
//   List<Object> get props => [
//         chunkHeaders,
//         chunkSize,
//         numberPattern,
//         prefix,
//         suffix,
//         totalBoards,
//       ];

//   // HoneygramManifest copyWith({
//   // }) {
//   //   return HoneygramManifest(
//   //   );
//   // }

//   factory HoneygramManifest.fromJson(Map<String, dynamic> json) {
//     List<HoneygramChunkHeader> chunkHeadersList = (json['chunkHeaders'] as List)
//         .map((headers) => headers as HoneygramChunkHeader)
//         .toList();

//     return HoneygramManifest(
//       chunkHeaders: chunkHeadersList,
//       chunkSize: json['chunkSize'] ?? 0,
//       numberPattern: json['numberPattern'] ?? '',
//       prefix: json['prefix'] ?? '',
//       suffix: json['suffix'] ?? '',
//       totalBoards: json['totalBoards'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'chunkHeaders': chunkHeaders,
//       'chunkSize': chunkSize,
//       'numberPattern': numberPattern,
//       'prefix': prefix,
//       'suffix': suffix,
//       'totalBoards': totalBoards,
//     };
//   }

//   String chunkNameFromIndex(int index) {
//     NumberFormat formatter = NumberFormat(numberPattern);
//     return '$prefix${formatter.format(index)}$suffix';
//   }

//   String? findChunkNameForBoardId(String boardId) {
//     // Assuming chunk headers are sorted?
//     for (var header in chunkHeaders) {
//       // boardId is after this chunk
//       if (header.last.compareTo(boardId) < 0) continue;
//       if (header.first.compareTo(boardId) <= 0) {
//         return chunkNameFromIndex(header.index);
//       }
//     }
//     return null;
//   }

//   static const emptyHoneygramManifest = HoneygramManifest(
//     chunkHeaders: [],
//     chunkSize: 0,
//     numberPattern: '',
//     prefix: '',
//     suffix: '',
//     totalBoards: 0,
//   );
// }
