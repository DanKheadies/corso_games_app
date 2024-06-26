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

class GetNewHoneygramBoard extends HoneygramEvent {
  final List<HoneygramBoard>? honeygramBoards;

  const GetNewHoneygramBoard({
    this.honeygramBoards = const [],
  });

  @override
  List<Object?> get props => [
        honeygramBoards,
      ];
}

class LoadHoneygramBoard extends HoneygramEvent {
  final bool loadFromFile;
  final BuildContext context;

  const LoadHoneygramBoard({
    required this.context,
    required this.loadFromFile,
  });

  @override
  List<Object> get props => [
        context,
        loadFromFile,
      ];
}

class ResetBoard extends HoneygramEvent {}
