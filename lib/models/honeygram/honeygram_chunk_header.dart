// import 'package:corso_games_app/models/models.dart';
// import 'package:equatable/equatable.dart';

// class HoneygramChunkHeader extends Equatable {
//   final int boardCount;
//   final int index;
//   final String first;
//   final String last;

//   const HoneygramChunkHeader({
//     required this.boardCount,
//     required this.index,
//     required this.first,
//     required this.last,
//   });

//   @override
//   List<Object> get props => [
//         boardCount,
//         first,
//         index,
//         last,
//       ];

//   // HoneygramChunkHeader copyWith({
//   // }) {
//   //   return HoneygramChunkHeader(
//   //   );
//   // }

//   factory HoneygramChunkHeader.fromJson(Map<String, dynamic> json) {
//     return HoneygramChunkHeader(
//       boardCount: json['boardCount'] ?? 0,
//       first: json['first'] ?? '',
//       index: json['index'] ?? 0,
//       last: json['last'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'boardCount': boardCount,
//       'first': first,
//       'index': index,
//       'last': last,
//     };
//   }

//   static List<HoneygramChunkHeader> headersForChunks(
//       List<List<HoneygramBoard>> chunks) {
//     List<HoneygramChunkHeader> chunkHeaders = [];
//     for (int index = 0; index < chunks.length; index++) {
//       List<HoneygramBoard> chunk = chunks[index];
//       chunkHeaders.add(
//         HoneygramChunkHeader(
//           boardCount: chunk.length,
//           first: chunk.first.id,
//           index: index,
//           last: chunk.last.id,
//         ),
//       );
//     }
//     return chunkHeaders;
//   }

//   static const emptyHoneygramChunkHeader = HoneygramChunkHeader(
//     boardCount: 0,
//     first: '',
//     index: 0,
//     last: '',
//   );
// }
