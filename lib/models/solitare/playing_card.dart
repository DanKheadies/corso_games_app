import 'package:equatable/equatable.dart';

enum CardSuit {
  spades,
  hearts,
  diamonds,
  clubs,
}

enum CardType {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king
}

enum CardColor {
  red,
  black,
}

// ignore: must_be_immutable
class PlayingCard extends Equatable {
  CardSuit cardSuit;
  CardType cardType;
  bool faceUp;
  bool opened;

  PlayingCard({
    required this.cardSuit,
    required this.cardType,
    this.faceUp = false,
    this.opened = false,
  });

  CardColor get cardColor {
    if (cardSuit == CardSuit.hearts || cardSuit == CardSuit.diamonds) {
      return CardColor.red;
    } else {
      return CardColor.black;
    }
  }

  PlayingCard copyWith({
    CardSuit? cardSuit,
    CardType? cardType,
    bool? faceUp,
    bool? opened,
  }) {
    return PlayingCard(
      cardSuit: cardSuit ?? this.cardSuit,
      cardType: cardType ?? this.cardType,
      faceUp: faceUp ?? this.faceUp,
      opened: opened ?? this.opened,
    );
  }

  factory PlayingCard.fromJson(Map<String, dynamic> json) {
    return PlayingCard(
      cardSuit: CardSuit.values.firstWhere(
        (suit) => suit.name.toString() == json['cardSuit'],
      ),
      cardType: CardType.values.firstWhere(
        (type) => type.name.toString() == json['cardType'],
      ),
      faceUp: json['faceUp'],
      opened: json['opened'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardSuit': cardSuit.name,
      'cardType': cardType.name,
      'faceUp': faceUp,
      'opened': opened,
    };
  }

  @override
  List<Object> get props => [
        cardSuit,
        cardType,
        faceUp,
        opened,
      ];
}
