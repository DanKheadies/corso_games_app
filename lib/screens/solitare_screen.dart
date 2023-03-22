import 'dart:math';

import 'package:flutter/material.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class SolitareScreen extends StatefulWidget {
  // static const String id = 'solitare';
  static const String routeName = '/solitare';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SolitareScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const SolitareScreen({super.key});

  @override
  State<SolitareScreen> createState() => _SolitareScreenState();
}

class _SolitareScreenState extends State<SolitareScreen> {
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
    _initializeGame();
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

    List<PlayingCard> allCards = [];

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

    cardDeckClosed = allCards;
    cardDeckOpened.add(
      cardDeckClosed.removeLast()
        ..opened = true
        ..faceUp = true,
    );

    setState(() {});
  }

  void _refreshList(int index) {
    if (finalDiamondsDeck.length +
            finalHeartsDeck.length +
            finalClubsDeck.length +
            finalSpadesDeck.length ==
        52) {
      _handleWin();
    }
    setState(() {
      if (_getListFromIndex(index).isNotEmpty) {
        _getListFromIndex(index)[_getListFromIndex(index).length - 1]
          ..opened = true
          ..faceUp = true;
      }
    });
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
            onTap: () {
              setState(() {
                if (cardDeckClosed.isEmpty) {
                  cardDeckClosed.addAll(
                    cardDeckOpened.map((card) {
                      return card
                        ..opened = false
                        ..faceUp = false;
                    }),
                  );
                  cardDeckOpened.clear();
                } else {
                  cardDeckOpened.add(
                    cardDeckClosed.removeLast()
                      ..faceUp = true
                      ..opened = true,
                  );
                }
              });
            },
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
    return ScreenWrapper(
      title: 'Solitare',
      infoTitle: 'Solitare',
      infoDetails:
          'Stack cards sequentially in their suit. You can reveal new cards by moving opposite colored cards onto cards that are one higher than their own value, e.g. a red six can be placed on a black seven.',
      button: 'Leggooo!',
      backgroundOverride: Theme.of(context).colorScheme.tertiary,
      content: Padding(
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
                    },
                    columnIndex: 7,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      screenFunction: (String string) {},
      // bottomBar: const BottomAppBar(),
      bottomBar: BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Settings',
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Share',
              icon: Icon(
                Icons.ios_share_outlined,
                // color: Colors.white,
                color: Theme.of(context).colorScheme.secondary,
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingButton: FloatingActionButton(
        // onPressed: resetGameBoard,
        onPressed: () {
          _initializeGame();
        },
        tooltip: 'Reset',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          icon: Icon(
            Icons.settings_backup_restore_rounded,
            color: Theme.of(context).colorScheme.background,
            size: 30,
          ),
          // onPressed: resetGameBoard,
          onPressed: () {
            _initializeGame();
          },
        ),
      ),
      floatingButtonLoc: FloatingActionButtonLocation.centerDocked,
    );
  }
}
