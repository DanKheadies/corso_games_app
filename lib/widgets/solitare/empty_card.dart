import 'package:corso_games_app/config/config.dart';
import 'package:corso_games_app/cubits/cubits.dart';
import 'package:corso_games_app/models/models.dart';
import 'package:corso_games_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyCardDeck extends StatefulWidget {
  final CardSuit cardSuit;
  final CardAcceptCallback onCardAdded;
  final double screenWidth;
  final List<PlayingCard> cardsAdded;
  final int columnIndex;

  const EmptyCardDeck({
    super.key,
    required this.cardSuit,
    required this.cardsAdded,
    required this.onCardAdded,
    required this.screenWidth,
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
      // default:
      //   return Image.asset('assets/images/solitare/back_side.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, listOne, listTwo) {
        return widget.cardsAdded.isEmpty
            ? Opacity(
                opacity: 0.7,
                child: BlocBuilder<BrightnessCubit, Brightness>(
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Responsive.isMobile(context) ? 0 : 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          // 8,
                          Responsive.isMobile(context) ? 8 : 16,
                        ),
                        color: state == Brightness.dark
                            ? Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withBlue(175)
                                .withGreen(175)
                                .withRed(175)
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                      // height: 60,
                      height: Responsive.isMobile(context)
                          ? 60
                          : (widget.screenWidth / 5), // 10
                      // width: 40,
                      width: Responsive.isMobile(context)
                          ? 40
                          : (widget.screenWidth / 8), // 15
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: SizedBox(
                                // height: 20,
                                height: Responsive.isMobile(context)
                                    ? 20
                                    : (widget.screenWidth / 20), // 30
                                child: _suitToImage(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : TransformedCard(
                playingCard: widget.cardsAdded.last,
                columnIndex: widget.columnIndex,
                attachedCards: [
                  widget.cardsAdded.last,
                ],
                screenWidth: widget.screenWidth,
              );
      },
      onWillAcceptWithDetails: (value) {
        final dataValues = value.data as Map;
        PlayingCard cardAdded = dataValues['cards'].last;

        if (cardAdded.cardSuit == widget.cardSuit) {
          if (CardType.values.indexOf(cardAdded.cardType) ==
              widget.cardsAdded.length) {
            return true;
          }
        }
        return false;
      },
      onAcceptWithDetails: (value) {
        final dataValues = value.data as Map;
        widget.onCardAdded(
          dataValues['cards'],
          dataValues['fromIndex'],
        );
      },
    );
  }
}
