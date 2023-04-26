import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/blocs/blocs.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

// ignore: library_private_types_in_public_api
// GlobalKey<_SolitareBoardState> solitareKey = GlobalKey();

class SolitareBoard extends StatefulWidget {
  final bool resetSolitare;
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
  final List<PlayingCard> finalHeartsDeck;
  final List<PlayingCard> finalDiamondsDeck;
  final List<PlayingCard> finalSpadesDeck;
  final List<PlayingCard> finalClubsDeck;

  const SolitareBoard({
    super.key,
    required this.resetSolitare,
    required this.allCards,
    required this.cardColumn1,
    required this.cardColumn2,
    required this.cardColumn3,
    required this.cardColumn4,
    required this.cardColumn5,
    required this.cardColumn6,
    required this.cardColumn7,
    required this.cardDeckClosed,
    required this.cardDeckOpened,
    required this.finalClubsDeck,
    required this.finalDiamondsDeck,
    required this.finalHeartsDeck,
    required this.finalSpadesDeck,
  });

  @override
  State<SolitareBoard> createState() => _SolitareBoardState();
}

class _SolitareBoardState extends State<SolitareBoard> {
  List<PlayingCard> allCards = [];

  List<PlayingCard> cardColumn1 = [];
  List<PlayingCard> cardColumn2 = [];
  List<PlayingCard> cardColumn3 = [];
  List<PlayingCard> cardColumn4 = [];
  List<PlayingCard> cardColumn5 = [];
  List<PlayingCard> cardColumn6 = [];
  List<PlayingCard> cardColumn7 = [];

  List<PlayingCard> cardDeckClosed = [];
  List<PlayingCard> cardDeckOpened = [];

  List<PlayingCard> finalHeartsDeck = [];
  List<PlayingCard> finalDiamondsDeck = [];
  List<PlayingCard> finalSpadesDeck = [];
  List<PlayingCard> finalClubsDeck = [];

  @override
  void initState() {
    super.initState();
    if (widget.allCards == []) {
      _initializeGame();
    } else {
      setState(() {
        allCards = widget.allCards;
        cardColumn1 = widget.cardColumn1;
        cardColumn2 = widget.cardColumn2;
        cardColumn3 = widget.cardColumn3;
        cardColumn4 = widget.cardColumn4;
        cardColumn5 = widget.cardColumn5;
        cardColumn6 = widget.cardColumn6;
        cardColumn7 = widget.cardColumn7;
        cardDeckClosed = widget.cardDeckClosed;
        cardDeckOpened = widget.cardDeckOpened;
        finalClubsDeck = widget.finalClubsDeck;
        finalDiamondsDeck = widget.finalDiamondsDeck;
        finalHeartsDeck = widget.finalHeartsDeck;
        finalSpadesDeck = widget.finalSpadesDeck;
      });
    }
  }

  void _initializeGame() {
    cardColumn1 = [];
    cardColumn2 = [];
    cardColumn3 = [];
    cardColumn4 = [];
    cardColumn5 = [];
    cardColumn6 = [];
    cardColumn7 = [];

    cardDeckClosed = [];
    cardDeckOpened = [];

    finalHeartsDeck = [];
    finalDiamondsDeck = [];
    finalSpadesDeck = [];
    finalClubsDeck = [];

    allCards = [];

    for (var suit in CardSuit.values) {
      for (var type in CardType.values) {
        allCards.add(PlayingCard(
          cardType: type,
          cardSuit: suit,
          faceUp: false,
        ));
      }
    }

    Random random = Random();

    for (int i = 0; i < 28; i++) {
      int randomNumber = random.nextInt(allCards.length);

      if (i == 0) {
        PlayingCard card = allCards[randomNumber];
        cardColumn1.add(
          card
            ..opened = true
            ..faceUp = true,
        );
        allCards.removeAt(randomNumber);
      } else if (i > 0 && i < 3) {
        if (i == 2) {
          PlayingCard card = allCards[randomNumber];
          cardColumn2.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn2.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else if (i > 2 && i < 6) {
        if (i == 5) {
          PlayingCard card = allCards[randomNumber];
          cardColumn3.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn3.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else if (i > 5 && i < 10) {
        if (i == 9) {
          PlayingCard card = allCards[randomNumber];
          cardColumn4.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn4.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else if (i > 9 && i < 15) {
        if (i == 14) {
          PlayingCard card = allCards[randomNumber];
          cardColumn5.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn5.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else if (i > 14 && i < 21) {
        if (i == 20) {
          PlayingCard card = allCards[randomNumber];
          cardColumn6.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn6.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      } else {
        if (i == 27) {
          PlayingCard card = allCards[randomNumber];
          cardColumn7.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn7.add(allCards[randomNumber]);
        }
        allCards.removeAt(randomNumber);
      }
    }

    allCards.shuffle();

    cardDeckClosed = allCards;
    cardDeckOpened.add(
      cardDeckClosed.removeLast()
        ..opened = true
        ..faceUp = true,
    );

    setState(() {});

    print('initialize');
    context.read<SolitareBloc>().add(
          UpdateCards(
            allCards: allCards,
            cardColumn1: cardColumn1,
            cardColumn2: cardColumn2,
            cardColumn3: cardColumn3,
            cardColumn4: cardColumn4,
            cardColumn5: cardColumn5,
            cardColumn6: cardColumn6,
            cardColumn7: cardColumn7,
            cardDeckClosed: cardDeckClosed,
            cardDeckOpened: cardDeckOpened,
            finalClubsDeck: finalClubsDeck,
            finalDiamondsDeck: finalDiamondsDeck,
            finalHeartsDeck: finalHeartsDeck,
            finalSpadesDeck: finalSpadesDeck,
          ),
        );
  }

  void _refreshList(int index) {
    if (finalDiamondsDeck.length +
            finalHeartsDeck.length +
            finalClubsDeck.length +
            finalSpadesDeck.length ==
        52) {
      _handleWin();
    }

    if (_getListFromIndex(index).isNotEmpty) {
      setState(() {
        _getListFromIndex(index)[_getListFromIndex(index).length - 1]
          ..opened = true
          ..faceUp = true;
      });

      print('refresh list');
      context.read<SolitareBloc>().add(
            UpdateCards(
              allCards: allCards,
            ),
          );
    }
  }

  void _handleWin() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You won!!'),
          actions: [
            TextButton(
              onPressed: () {
                _initializeGame();
                Navigator.pop(context);
              },
              child: const Text('Play again'),
            ),
          ],
        );
      },
    );
  }

  List<PlayingCard> _getListFromIndex(int index) {
    switch (index) {
      case 0:
        return cardDeckOpened;
      case 1:
        return cardColumn1;
      case 2:
        return cardColumn2;
      case 3:
        return cardColumn3;
      case 4:
        return cardColumn4;
      case 5:
        return cardColumn5;
      case 6:
        return cardColumn6;
      case 7:
        return cardColumn7;
      case 8:
        return finalHeartsDeck;
      case 9:
        return finalDiamondsDeck;
      case 10:
        return finalSpadesDeck;
      case 11:
        return finalClubsDeck;
      default:
        return [];
    }
  }

  SizedBox _buildCardDeck() {
    return SizedBox(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (cardDeckClosed.isEmpty) {
                setState(() {
                  cardDeckClosed.addAll(
                    cardDeckOpened.map((card) {
                      return card
                        ..opened = false
                        ..faceUp = false;
                    }),
                  );
                  cardDeckOpened.clear();
                });

                context.read<SolitareBloc>().add(
                      UpdateCards(
                        cardDeckClosed: cardDeckClosed,
                        cardDeckOpened: cardDeckOpened,
                      ),
                    );
              } else {
                setState(() {
                  cardDeckOpened.add(
                    cardDeckClosed.removeLast()
                      ..faceUp = true
                      ..opened = true,
                  );
                });

                print('tap card deck & not empty');
                context.read<SolitareBloc>().add(
                      UpdateCards(
                        cardDeckClosed: cardDeckClosed,
                        cardDeckOpened: cardDeckOpened,
                      ),
                    );
              }
            },
            child: cardDeckClosed.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(4),
                    child: TransformedCard(
                      playingCard: cardDeckClosed.last,
                    ),
                  )
                : Opacity(
                    opacity: 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: TransformedCard(
                        playingCard: PlayingCard(
                          cardSuit: CardSuit.diamonds,
                          cardType: CardType.five,
                        ),
                      ),
                    ),
                  ),
          ),
          cardDeckOpened.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(4),
                  child: TransformedCard(
                    playingCard: cardDeckOpened.last,
                    attachedCards: [
                      cardDeckOpened.last,
                    ],
                    columnIndex: 0,
                  ),
                )
              : const SizedBox(width: 40),
        ],
      ),
    );
  }

  SizedBox _buildFinalDecks() {
    return SizedBox(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: EmptyCardDeck(
              cardSuit: CardSuit.hearts,
              cardsAdded: finalHeartsDeck,
              onCardAdded: (cards, index) {
                finalHeartsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);

                context.read<SolitareBloc>().add(
                      UpdateCards(
                        finalHeartsDeck: finalHeartsDeck,
                      ),
                    );
              },
              columnIndex: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: EmptyCardDeck(
              cardSuit: CardSuit.diamonds,
              cardsAdded: finalDiamondsDeck,
              onCardAdded: (cards, index) {
                finalDiamondsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);

                context.read<SolitareBloc>().add(
                      UpdateCards(
                        finalDiamondsDeck: finalDiamondsDeck,
                      ),
                    );
              },
              columnIndex: 9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: EmptyCardDeck(
              cardSuit: CardSuit.spades,
              cardsAdded: finalSpadesDeck,
              onCardAdded: (cards, index) {
                finalSpadesDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);

                context.read<SolitareBloc>().add(
                      UpdateCards(
                        finalSpadesDeck: finalSpadesDeck,
                      ),
                    );
              },
              columnIndex: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: EmptyCardDeck(
              cardSuit: CardSuit.clubs,
              cardsAdded: finalClubsDeck,
              onCardAdded: (cards, index) {
                finalClubsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);

                context.read<SolitareBloc>().add(
                      UpdateCards(
                        finalClubsDeck: finalClubsDeck,
                      ),
                    );
              },
              columnIndex: 11,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.resetSolitare) {
      _initializeGame();
      context.read<SolitareBloc>().add(
            ToggleSolitare(),
          );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCardDeck(),
              _buildFinalDecks(),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CardColumn(
                  cards: cardColumn1,
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumn1.addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });

                    context.read<SolitareBloc>().add(
                          UpdateCards(
                            cardColumn1: cardColumn1,
                          ),
                        );
                  },
                  columnIndex: 1,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn2,
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumn2.addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });

                    context.read<SolitareBloc>().add(
                          UpdateCards(
                            cardColumn2: cardColumn2,
                          ),
                        );
                  },
                  columnIndex: 2,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn3,
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumn3.addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });

                    context.read<SolitareBloc>().add(
                          UpdateCards(
                            cardColumn3: cardColumn3,
                          ),
                        );
                  },
                  columnIndex: 3,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn4,
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumn4.addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });

                    context.read<SolitareBloc>().add(
                          UpdateCards(
                            cardColumn4: cardColumn4,
                          ),
                        );
                  },
                  columnIndex: 4,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn5,
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumn5.addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });

                    context.read<SolitareBloc>().add(
                          UpdateCards(
                            cardColumn5: cardColumn5,
                          ),
                        );
                  },
                  columnIndex: 5,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn6,
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumn6.addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });

                    context.read<SolitareBloc>().add(
                          UpdateCards(
                            cardColumn6: cardColumn6,
                          ),
                        );
                  },
                  columnIndex: 6,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn7,
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumn7.addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });

                    context.read<SolitareBloc>().add(
                          UpdateCards(
                            cardColumn7: cardColumn7,
                          ),
                        );
                  },
                  columnIndex: 7,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
