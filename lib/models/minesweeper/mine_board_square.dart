class MineBoardSquare {
  bool hasBomb;
  int bombsAround;

  MineBoardSquare({
    this.hasBomb = false,
    this.bombsAround = 0,
  });

  factory MineBoardSquare.fromJson(Map<String, dynamic> json) {
    return MineBoardSquare(
      hasBomb: json['hasBomb'],
      bombsAround: json['bombsAround'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasBomb': hasBomb,
      'bombsAround': bombsAround,
    };
  }
}
