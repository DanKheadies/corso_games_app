import 'package:flutter/material.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class EmptyCardDeck extends StatefulWidget {
  final CardSuit cardSuit;
  final List<PlayingCard> cardsAdded;
  final CardAcceptCallback onCardAdded;
  final int columnIndex;

  const EmptyCardDeck({
    super.key,
    required this.cardSuit,
    required this.cardsAdded,
    required this.onCardAdded,
    this.columnIndex = 0,
  });

  @override
  State<EmptyCardDeck> createState() => _EmptyCardDeckState();
}

class _EmptyCardDeckState extends State<EmptyCardDeck> {
  Image _suitToImage() {
    switch (widget.cardSuit) {
      case CardSuit.hearts:
        return Image.asset('assets/images/solitare/hearts.png');
      case CardSuit.diamonds:
        return Image.asset('assets/images/solitare/diamonds.png');
      case CardSuit.clubs:
        return Image.asset('assets/images/solitare/clubs.png');
      case CardSuit.spades:
        return Image.asset('assets/images/solitare/spades.png');
      default:
        return Image.asset('assets/images/solitare/back_side.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, listOne, listTwo) {
        return widget.cardsAdded.isEmpty
            ? Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  height: 60,
                  width: 40,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 20,
                            child: _suitToImage(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : TransformedCard(
                playingCard: widget.cardsAdded.last,
                columnIndex: widget.columnIndex,
                attachedCards: [
                  widget.cardsAdded.last,
                ],
              );
      },
      onWillAccept: (value) {
        final dataValues = value as Map;
        PlayingCard cardAdded = dataValues['cards'].last;

        if (cardAdded.cardSuit == widget.cardSuit) {
          if (CardType.values.indexOf(cardAdded.cardType) ==
              widget.cardsAdded.length) {
            return true;
          }
        }
        return false;
      },
      onAccept: (value) {
        final dataValues = value as Map;
        widget.onCardAdded(
          dataValues['cards'],
          dataValues['fromIndex'],
        );
      },
    );
  }
}
