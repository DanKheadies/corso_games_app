import 'package:flutter/material.dart';

import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

typedef CardAcceptCallback = Null Function(
  List<PlayingCard> card,
  int fromIndex,
);

class CardColumn extends StatefulWidget {
  final List<PlayingCard> cards;
  final CardAcceptCallback onCardsAdded;
  final int columnIndex;

  const CardColumn({
    super.key,
    required this.cards,
    required this.onCardsAdded,
    required this.columnIndex,
  });

  @override
  State<CardColumn> createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 7,
      margin: const EdgeInsets.all(2),
      child: DragTarget(
        builder: (context, listOne, listTwo) {
          return Stack(
            children: widget.cards.map((card) {
              int index = widget.cards.indexOf(card);
              return TransformedCard(
                playingCard: card,
                transformIndex: index,
                attachedCards: widget.cards.sublist(
                  index,
                  widget.cards.length,
                ),
                columnIndex: widget.columnIndex,
              );
            }).toList(),
          );
        },
        onWillAccept: (data) {
          if (widget.cards.isEmpty) {
            return true;
          }

          final dataValues = data as Map;
          List<PlayingCard> draggedCards = dataValues['cards'];
          PlayingCard firstCard = draggedCards.first;
          if (firstCard.cardColor == CardColor.red) {
            if (widget.cards.last.cardColor == CardColor.red) {
              return false;
            }

            int lastColumnCardIndex =
                CardType.values.indexOf(widget.cards.last.cardType);
            int firstDraggedCardIndex =
                CardType.values.indexOf(firstCard.cardType);

            if (lastColumnCardIndex != firstDraggedCardIndex + 1) {
              return false;
            }
          } else {
            if (widget.cards.last.cardColor == CardColor.black) {
              return false;
            }

            int lastColumnCardIndex =
                CardType.values.indexOf(widget.cards.last.cardType);
            int firstDraggedCardIndex =
                CardType.values.indexOf(firstCard.cardType);

            if (lastColumnCardIndex != firstDraggedCardIndex + 1) {
              return false;
            }
          }
          return true;
        },
        onAccept: (data) {
          final dataValues = data as Map;
          widget.onCardsAdded(
            dataValues['cards'],
            dataValues['fromIndex'],
          );
        },
      ),
    );
  }
}
