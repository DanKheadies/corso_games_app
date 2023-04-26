part of 'solitare_bloc.dart';

enum SolitareStatus {
  loading,
  loaded,
  won,
  error,
}

class SolitareState extends Equatable {
  final bool resetSolitare;
  final SolitareStatus solitareStatus;
  final List<PlayingCard> allCards;
  final List<PlayingCard> cardColumn1;
  final List<PlayingCard> cardColumn2;
  final List<PlayingCard> cardColumn3;
  final List<PlayingCard> cardColumn4;
  final List<PlayingCard> cardColumn5;
  final List<PlayingCard> cardColumn6;
  final List<PlayingCard> cardColumn7;
  final List<PlayingCard> cardDeckClosed;
  final List<PlayingCard> cardDeckOpened;
  final List<PlayingCard> finalClubsDeck;
  final List<PlayingCard> finalDiamondsDeck;
  final List<PlayingCard> finalHeartsDeck;
  final List<PlayingCard> finalSpadesDeck;
  final int todoTicker;

  const SolitareState({
    this.resetSolitare = false,
    this.solitareStatus = SolitareStatus.loading,
    this.allCards = const [],
    this.cardColumn1 = const [],
    this.cardColumn2 = const [],
    this.cardColumn3 = const [],
    this.cardColumn4 = const [],
    this.cardColumn5 = const [],
    this.cardColumn6 = const [],
    this.cardColumn7 = const [],
    this.cardDeckClosed = const [],
    this.cardDeckOpened = const [],
    this.finalClubsDeck = const [],
    this.finalDiamondsDeck = const [],
    this.finalHeartsDeck = const [],
    this.finalSpadesDeck = const [],
    this.todoTicker = 0,
  });

  factory SolitareState.fromJson(Map<String, dynamic> json) {
    List<PlayingCard> allCardsList = (json['allCards'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cc1List = (json['cardColumn1'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cc2List = (json['cardColumn2'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cc3List = (json['cardColumn3'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cc4List = (json['cardColumn4'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cc5List = (json['cardColumn5'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cc6List = (json['cardColumn6'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cc7List = (json['cardColumn7'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cdClosedList = (json['cardDeckClosed'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> cdOpenedList = (json['cardDeckOpened'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> finalClubsList = (json['finalClubsDeck'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> finalDiamondsList = (json['finalDiamondsDeck'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> finalHeartsList = (json['finalHeartsDeck'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();
    List<PlayingCard> finalSpadesList = (json['finalSpadesDeck'] as List)
        .map((card) => PlayingCard.fromJson(card))
        .toList();

    return SolitareState(
      resetSolitare: json['resetSolitare'],
      solitareStatus: SolitareStatus.values.firstWhere(
        (status) => status.name.toString() == json['solitareStatus'],
      ),
      allCards: allCardsList,
      cardColumn1: cc1List,
      cardColumn2: cc2List,
      cardColumn3: cc3List,
      cardColumn4: cc4List,
      cardColumn5: cc5List,
      cardColumn6: cc6List,
      cardColumn7: cc7List,
      cardDeckClosed: cdClosedList,
      cardDeckOpened: cdOpenedList,
      finalClubsDeck: finalClubsList,
      finalDiamondsDeck: finalDiamondsList,
      finalHeartsDeck: finalHeartsList,
      finalSpadesDeck: finalSpadesList,
      todoTicker: json['todoTicker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resetSolitare': resetSolitare,
      'solitareStatus': solitareStatus.name,
      'allCards': allCards,
      'cardColumn1': cardColumn1,
      'cardColumn2': cardColumn2,
      'cardColumn3': cardColumn3,
      'cardColumn4': cardColumn4,
      'cardColumn5': cardColumn5,
      'cardColumn6': cardColumn6,
      'cardColumn7': cardColumn7,
      'cardDeckClosed': cardDeckClosed,
      'cardDeckOpened': cardDeckOpened,
      'finalClubsDeck': finalClubsDeck,
      'finalDiamondsDeck': finalDiamondsDeck,
      'finalHeartsDeck': finalHeartsDeck,
      'finalSpadesDeck': finalSpadesDeck,
      'todoTicker': todoTicker,
    };
  }

  @override
  List<Object> get props => [
        resetSolitare,
        solitareStatus,
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
        todoTicker,
      ];
}
