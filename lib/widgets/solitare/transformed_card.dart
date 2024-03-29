import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';

class TransformedCard extends StatefulWidget {
  final PlayingCard playingCard;
  final double transformDistance;
  final int transformIndex;
  final int columnIndex;
  final List<PlayingCard> attachedCards;

  const TransformedCard({
    super.key,
    required this.playingCard,
    this.transformDistance = 15.0,
    this.transformIndex = 0,
    this.columnIndex = 0,
    this.attachedCards = const [],
  });

  @override
  State<TransformedCard> createState() => _TransformedCardState();
}

class _TransformedCardState extends State<TransformedCard> {
  String _cardTypeToString() {
    switch (widget.playingCard.cardType) {
      case CardType.ace:
        return "A";
      case CardType.two:
        return "2";
      case CardType.three:
        return "3";
      case CardType.four:
        return "4";
      case CardType.five:
        return "5";
      case CardType.six:
        return "6";
      case CardType.seven:
        return "7";
      case CardType.eight:
        return "8";
      case CardType.nine:
        return "9";
      case CardType.ten:
        return "10";
      case CardType.jack:
        return "J";
      case CardType.queen:
        return "Q";
      case CardType.king:
        return "K";
      default:
        return "";
    }
  }

  Image _suitToImage() {
    switch (widget.playingCard.cardSuit) {
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

  Widget _buildCard(Brightness state) {
    return !widget.playingCard.faceUp
        ? Container(
            height: 60,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: state == Brightness.dark
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.onBackground,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        : Draggable<Map>(
            feedback: CardColumn(
              cards: widget.attachedCards,
              columnIndex: 1,
              onCardsAdded: (card, position) {
                setState(() {});
              },
            ),
            childWhenDragging: _buildFaceUpCard(state),
            data: {
              'cards': widget.attachedCards,
              'fromIndex': widget.columnIndex,
            },
            child: _buildFaceUpCard(state),
          );
  }

  Widget _buildFaceUpCard(Brightness state) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            // color: Colors.black,
            color: state == Brightness.dark
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.onBackground,
          ),
          borderRadius: BorderRadius.circular(8),
          color: state == Brightness.dark
              ? Theme.of(context)
                  .colorScheme
                  .surface
                  .withBlue(175)
                  .withGreen(175)
                  .withRed(175)
              : Theme.of(context).colorScheme.onSurface,
        ),
        height: 60,
        width: 40,
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      _cardTypeToString(),
                      style: TextStyle(
                        color: state == Brightness.dark
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.onBackground,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: _suitToImage(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _cardTypeToString(),
                      style: TextStyle(
                        color: state == Brightness.dark
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.onBackground,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      child: _suitToImage(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrightnessCubit, Brightness>(
      builder: (context, state) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
              0.0,
              widget.transformIndex * widget.transformDistance,
              0.0,
            ),
          child: _buildCard(state),
        );
      },
    );
  }
}
