import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransformedCard extends StatefulWidget {
  final PlayingCard playingCard;
  final double screenWidth;
  final double transformDistance;
  final int transformIndex;
  final int columnIndex;
  final List<PlayingCard> attachedCards;

  const TransformedCard({
    super.key,
    required this.playingCard,
    required this.screenWidth,
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
            // height: 60,
            height: Responsive.isMobile(context)
                ? 60
                : (widget.screenWidth / 5) + 10, // 10 + 10
            // width: 40,
            width: Responsive.isMobile(context)
                ? 40
                : (widget.screenWidth / 8) + 10, // 15 + 10
            decoration: BoxDecoration(
              border: Border.all(
                color: state == Brightness.dark
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.surface,
              ),
              // borderRadius: BorderRadius.circular(8),
              borderRadius: BorderRadius.circular(
                // Responsive.isMobile(context) ? 8 : (widget.screenWidth / 75),
                Responsive.isMobile(context) ? 8 : 16,
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        : Draggable<Map<dynamic, dynamic>>(
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
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.surface,
          ),
          borderRadius: BorderRadius.circular(
            // 8,
            Responsive.isMobile(context) ? 8 : 16,
          ),
          color: state == Brightness.dark
              ? Theme.of(context)
                  .colorScheme
                  .surface
                  .withBlue(175)
                  .withGreen(175)
                  .withRed(175)
              : Theme.of(context).colorScheme.onSurface,
        ),
        // height: 60,
        height: Responsive.isMobile(context)
            ? 60
            : (widget.screenWidth / 5) + 10, // 10 + 10
        // width: 40,
        width: Responsive.isMobile(context)
            ? 40
            : (widget.screenWidth / 8) + 10, // 15 + 10
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
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.surface,
                        // fontSize: 16,
                        fontSize: Responsive.isMobile(context)
                            ? 16
                            : (widget.screenWidth / 37.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 20,
                    height: Responsive.isMobile(context)
                        ? 20
                        : (widget.screenWidth / 30),
                    child: _suitToImage(),
                  ),
                ],
              ),
            ),
            Padding(
              // padding: const EdgeInsets.all(4),
              padding: EdgeInsets.all(
                Responsive.isMobile(context) ? 4 : (widget.screenWidth / 150),
              ),
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
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.surface,
                        // fontSize: 10,
                        fontSize: Responsive.isMobile(context)
                            ? 10
                            : (widget.screenWidth / 60),
                      ),
                    ),
                    SizedBox(
                      // height: 10,
                      height: Responsive.isMobile(context)
                          ? 10
                          : (widget.screenWidth / 60),
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
              widget.transformIndex *
                  widget.transformDistance *
                  (Responsive.isMobile(context) ? 1 : 2),
              0.0,
            ),
          child: _buildCard(state),
        );
      },
    );
  }
}
