import 'package:corso_games_app/models/models.dart';

Future<List<HoneygramBoard>> generateHoneygramBoards({
  required List<String> wordList,
  required HoneygramWordFrequencies frequencies,
}) async {
  int maxDifficulty = 0;
  List<HoneygramBoard> allBoards = [];
  List<HoneygramLetterCluster> clusters = await computeLetterClusters(
    wordList: wordList,
  );

  clusters.sort((a, b) => a.letters.compareTo(b.letters));

  for (HoneygramLetterCluster cluster in clusters) {
    for (String center in cluster.letterSet) {
      List<String> validWords =
          cluster.words.where((word) => word.contains(center)).toList();

      // FIXME: This lookup should be done at Cluster construction time
      // rather than at least 7x as common during *board* construction.
      int difficulty = validWords.fold(
        0,
        (previous, word) =>
            previous +
            rarityScore(
              frequencies.rarityPercentile(word),
            ),
      );

      if (difficulty > maxDifficulty) maxDifficulty = difficulty;

      allBoards.add(
        HoneygramBoard(
          center: center,
          otherLetters:
              cluster.letterSet.where((letter) => letter != center).toList(),
          validWords: validWords,
          difficultyScore: difficulty,
        ),
      );
    }
  }

  // Normalize difficulty scores:
  // print("Normalizing board difficulties from max $maxDifficulty");
  // FIXME: Max is 11790!? So presumably this should be weighted somehow?
  // Or outlier boards e.g. exceptionally large numbers of words, should
  // just be discarded?
  // TODO: this always returns null (with temp word bank)
  // Try using all words and see
  // Update: still didn't show the correct end result; not sure if this is the
  // hang up or if it's further down the chain.
  for (int i = 0; i < allBoards.length; i++) {
    allBoards[i].copyWith(
      difficultyPercentile: allBoards[i].difficultyScore / maxDifficulty,
    );
  }

  return allBoards;
}

Future<List<HoneygramLetterCluster>> computeLetterClusters({
  required List<String> wordList,
}) async {
  // print('Getting legal words from list of ${wordList.length} words');
  List<String> legalWords = wordList
      .where((word) => (word.length >= 4 && !word.contains('s')))
      .toList();
  // print("Creating clusters from ${legalWords.length} legal words");
  await Future.delayed(const Duration(milliseconds: 100));
  Set<String> letterSets = {};

  // print('TODO: reactivate the official list post styling / caching / checks');
  // List<String> derp = ['unfroze', 'redcoat', 'reaming'];
  // for (int i = 0; i < derp.length; i++) {
  //   List<String> letters = List.from(
  //     Set.from(
  //       derp[i].split(""),
  //     ),
  //   );
  //   if (letters.length != 7) continue;
  //   letters.sort();
  //   letterSets.add(letters.join(""));
  // }

  for (String word in legalWords) {
    List<String> letters = List.from(
      Set.from(
        word.split(""),
      ),
    );
    if (letters.length != 7) continue;
    letters.sort();
    letterSets.add(letters.join(""));
  }

  List<HoneygramLetterCluster> clusters = [];
  for (String letters in letterSets) {
    clusters.add(
      HoneygramLetterCluster(
        letters: letters,
      ),
    );
  }

  // print("Adding words to ${clusters.length} clusters");
  // TODO: find a way to avoid this it takes too much time / processing power
  for (String word in legalWords) {
    // Could have cached this from first walk.
    List<String> wordLetters = word.trim().split("");
    // TODO: reduce this or find how it can load async
    // Note: making this function a Future didn't seem to do it
    for (HoneygramLetterCluster cluster in clusters) {
      // 63% of time is spent in containsAll
      // Perhaps a walk of two sorted strings would be faster?
      if (cluster.letterSet.containsAll(wordLetters)) {
        cluster.words.add(word);
      }
    }
  }

  await Future.delayed(const Duration(milliseconds: 100));

  return clusters;
}

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
