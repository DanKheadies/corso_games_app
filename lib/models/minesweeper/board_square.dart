class BoardSquare {
  BoardSquare({
    this.hasBomb = false,
    this.bombsAround = 0,
  });

  bool hasBomb;
  int bombsAround;
}
