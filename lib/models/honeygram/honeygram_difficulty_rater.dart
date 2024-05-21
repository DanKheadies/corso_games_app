class HoneygramDifficultyRater {
  // FIXME: Tune hardness approximation.
  // 10 = very hard (rarest 25% or not found)
  // 5 = hard (rarest 50%)
  // 3 = medium (rarest 75%)
  // 1 = easy
  int rarityScore(double rarityPercent) {
    if (rarityPercent < 0.25) return 1;
    if (rarityPercent < 0.5) return 3;
    if (rarityPercent < 0.75) return 5;
    return 10;
  }
}
