part of 'solitare_bloc.dart';

class SolitareEvent extends Equatable {
  const SolitareEvent();

  @override
  List<Object?> get props => [];
}

class LoadSolitare extends SolitareEvent {}

class ToggleSolitareReset extends SolitareEvent {}

class TestSolitare extends SolitareEvent {
  final int? test;

  const TestSolitare({
    this.test,
  });

  @override
  List<Object?> get props => [
        test,
      ];
}

class UpdateCards extends SolitareEvent {
  final List<PlayingCard>? allCards;
  final List<PlayingCard>? cardColumn1;
  final List<PlayingCard>? cardColumn2;
  final List<PlayingCard>? cardColumn3;
  final List<PlayingCard>? cardColumn4;
  final List<PlayingCard>? cardColumn5;
  final List<PlayingCard>? cardColumn6;
  final List<PlayingCard>? cardColumn7;
  final List<PlayingCard>? cardDeckClosed;
  final List<PlayingCard>? cardDeckOpened;
  final List<PlayingCard>? finalClubsDeck;
  final List<PlayingCard>? finalDiamondsDeck;
  final List<PlayingCard>? finalHeartsDeck;
  final List<PlayingCard>? finalSpadesDeck;

  const UpdateCards({
    this.allCards,
    this.cardColumn1,
    this.cardColumn2,
    this.cardColumn3,
    this.cardColumn4,
    this.cardColumn5,
    this.cardColumn6,
    this.cardColumn7,
    this.cardDeckClosed,
    this.cardDeckOpened,
    this.finalClubsDeck,
    this.finalDiamondsDeck,
    this.finalHeartsDeck,
    this.finalSpadesDeck,
  });

  @override
  List<Object?> get props => [
        allCards,
        cardColumn1,
        cardColumn2,
        cardColumn3,
        cardColumn4,
        cardColumn5,
        cardColumn6,
        cardColumn7,
        cardDeckClosed,
        cardDeckOpened,
        finalClubsDeck,
        finalDiamondsDeck,
        finalHeartsDeck,
        finalSpadesDeck,
      ];
}
