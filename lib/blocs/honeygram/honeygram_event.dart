part of 'honeygram_bloc.dart';

class HoneygramEvent extends Equatable {
  const HoneygramEvent();

  @override
  List<Object?> get props => [];
}

class FoundWord extends HoneygramEvent {
  final String word;

  const FoundWord({
    required this.word,
  });

  @override
  List<Object> get props => [
        word,
      ];
}

class LoadHoneygramBoard extends HoneygramEvent {
  final BuildContext context;

  const LoadHoneygramBoard({
    required this.context,
  });

  @override
  List<Object> get props => [
        context,
      ];
}

// class ScoreForWord extends HoneygramEvent {
//   final String word;

//   const ScoreForWord({
//     required this.word,
//   });

//   @override
//   List<Object> get props => [
//         word,
//       ];
// }

class UpdateBoard extends HoneygramEvent {}
