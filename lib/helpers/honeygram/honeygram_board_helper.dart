import 'package:corso_games_app/models/models.dart';

Future<List<HoneygramBoard>> generateHoneygramBoards({
  // required HoneygramWordList wordList,
  required List<String> wordList,
  required HoneygramWordFrequencies frequencies,
}) async {
  print('start generation..');
  HoneygramDifficultyRater rater = HoneygramDifficultyRater();
  int maxDifficulty = 0;
  List<HoneygramBoard> allBoards = [];
  List<HoneygramLetterCluster> clusters = await computeLetterClusters(
    wordList: wordList,
  );
  print('total clusters: ${clusters.length}');
  print('first:');
  print(clusters[0].letters);
  print(clusters[0].letterSet);
  print(clusters[0].words);

  clusters.sort((a, b) => a.letters.compareTo(b.letters));

  // print('first after sort:');
  // print(clusters[0].letters);
  // print(clusters[0].letterSet);
  // print(clusters[0].words);

  // maxWordCount 269 for the norvig list
  // int maxWordCount =
  //     clusters.fold(0, (maxWords, cluster) => cluster.words.length);
  // print("Clusters maxWordCount: $maxWordCount");

  // TODO: valids words are only being populated with one leter in the set
  // TODO: center is missing? so its taking the first letter from the 6
  // UDPATE: first letter in the set is missing at this point..
  // i.e. , a, g, i, n, r, t} instead of (ex) {m, a, g, i, n, r, t}
  // Could be because it's not 7 letters. Could be because it had and "s"
  // and was removed further up the chain.
  // UPDATE: damn whitespace...
  print('assign center now.. but we down to 6 letters so go back up the chain');
  for (String center in clusters[0].letterSet) {
    // print('using that clusters letterSet:');
    // print(center);
    // print('thats prob null');
    List<String> validWords =
        clusters[0].words.where((word) => word.contains(center)).toList();

    // FIXME: This lookup should be done at Cluster construction time
    // rather than at least 7x as common during *board* construction.
    int difficulty = validWords.fold(
      0,
      (previous, word) =>
          previous +
          rater.rarityScore(
            frequencies.rarityPercentile(word),
          ),
    );

    if (difficulty > maxDifficulty) maxDifficulty = difficulty;

    List derpList =
        clusters[0].letterSet.where((letter) => letter != center).toList();
    print(center);
    print(derpList);
    print(validWords);
    print(difficulty);
    // allBoards.add(
    //   HoneygramBoard(
    //     center: center,
    //     otherLetters:
    //         cluster.letterSet.where((letter) => letter != center).toList(),
    //     validWords: validWords,
    //     difficultyScore: difficulty,
    //   ),
    // );
  }

  for (HoneygramLetterCluster cluster in clusters) {
    // print('using cluster:');
    // print(cluster.letterSet);
    // print(cluster.letters);
    // print(cluster.words);
    // Note: basically saying for each character / string in the set
    // So it's going to look into all the words associated with that cluster
    // and if the word contains that character, it will add it to the list of valid words.
    for (String center in cluster.letterSet) {
      // print('using that clusters letterSet:');
      // print(center);
      // print('thats prob null');
      List<String> validWords =
          cluster.words.where((word) => word.contains(center)).toList();

      // FIXME: This lookup should be done at Cluster construction time
      // rather than at least 7x as common during *board* construction.
      int difficulty = validWords.fold(
        0,
        (previous, word) =>
            previous +
            rater.rarityScore(
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
  print('cluster fuckery done..');
  print(allBoards[0].center);
  print(allBoards[0].otherLetters);
  print(allBoards[0].validWords);
  print(allBoards[0].difficultyScore);

  // Normalize difficulty scores:
  print("Normalizing board difficulties from max $maxDifficulty");
  // FIXME: Max is 11790!? So presumably this should be weighted somehow?
  // Or outlier boards e.g. exceptionally large numbers of words, should
  // just be discarded?
  // for (HoneygramBoard board in allBoards) {
  //   board.copyWith(
  //     difficultyPercentile: board.difficultyScore / maxDifficulty,
  //   );
  // }
  for (int i = 0; i < allBoards.length; i++) {
    allBoards[i].copyWith(
      difficultyPercentile: allBoards[i].difficultyScore / maxDifficulty,
    );
  }

  return allBoards;
}

// bool isLegalWord(String word) {
//   // Also exclude words with S in them?
//   // https://nytbee.com/ suggests S is not allowed.
//   // https://nytbee.com/ suggests NYT never goes above 80 words!
//   // return (word.length >= 4 && !word.contains('s'));
//   // print(word);
//   if (word == 'growl') {
//     print('growl is here');
//   }
//   return (word.length >= 4);
// }

Future<List<HoneygramLetterCluster>> computeLetterClusters({
  required List<String> wordList,
}) async {
  print('Getting legal words from list of ${wordList.length} words');
  // String growl = wordList[7078];
  // print(wordList[7078]);
  // print(growl);
  // List<String> derps = [];
  // for (var word in wordList) {
  //   derps.add(word.trim());
  // }
  // if (derps.contains('growl')) {
  //   print('************************** DACO ***********************');
  // }
  // if (growl.trim() == 'growl') {
  //   print('************************** TACO ***********************');
  // }
  // print('************************** FLAME ***********************');
  List<String> legalWords = wordList
      .where((word) => (word.length >= 4 && !word.contains('s')))
      .toList();
  print("Creating clusters from ${legalWords.length} legal words");
  await Future.delayed(const Duration(milliseconds: 100));
  Set<String> letterSets = {};

  print('help');
  List<String> derp = ['dropout', 'oarlike', 'combine'];
  for (int i = 0; i < derp.length; i++) {
    List<String> letters = List.from(
      Set.from(
        derp[i].split(""),
      ),
    );
    print(letters.length);
    print(letters);
    if (letters.length != 7) continue;
    print('carry on');
    letters.sort();
    letterSets.add(letters.join(""));
    print(letters);
    print(letterSets);
  }

  // print('first legalword: ${legalWords[0]}');
  // print('10th legalword: ${legalWords[9]}');
  // print('100th legalword: ${legalWords[99]}');
  // for (String word in legalWords) {
  //   // if (word.length == 7) {
  //   //   List<String> letters = List.from(
  //   //     Set.from(
  //   //       word.split(""),
  //   //     ),
  //   //   );
  //   //   // if (letters.length != 7) continue;
  //   //   // letters.sort();
  //   //   // letterSets.add(letters.join(""));
  //   //   // if (letters.length == 7) {
  //   //   // print(letters);
  //   //   letters.sort();
  //   //   // print(letters);
  //   //   letterSets.add(letters.join(""));
  //   //   // }
  //   // }
  //   List<String> letters = List.from(
  //     Set.from(
  //       word.split(""),
  //     ),
  //   );
  //   if (letters.length != 7) continue;
  //   letters.sort();
  //   letterSets.add(letters.join(""));
  // }
  // TODO: reactivate step above
  print('haz list of strings / words');
  // print('letterSet: ${letterSets.first}');
  print('wtf:');
  print(letterSets.first);
  print('letterSet #: ${letterSets.length}');

  // TODO: center not being set
  // Update: we're losing a letter from the set, and it's not being saved
  // as the center, i.e. it gets "saved" as the center later
  List<HoneygramLetterCluster> clusters = [];
  // clusters contain:
  // a string of letters
  // a set of letters / strings (letterSet)
  // a list of words / strings
  for (String letters in letterSets) {
    clusters.add(
      HoneygramLetterCluster(
        letters: letters,
      ),
    );
  }
  print('first cluster:');
  print(clusters[0].letters); // this should be 7 letters
  print(clusters[0].letterSet); // 6 letters seperated by commas w/ } at end
  print(clusters[0].words); // empty here

  print('second cluster:');
  print(clusters[1].letters); // this should be 7 letters
  print(clusters[1].letterSet); // 6 letters seperated by commas w/ } at end
  print(clusters[1].words); // empty here

  // String derpCenter = clusters[0].letterSet.first;
  // print(derpCenter);
  // for (String center in clusters[0].letterSet) {
  //   print('in the computer');
  //   print(center);
  // }

  // print(legalWords.length);
  // for (String word in legalWords) {
  //   if (word == 'growl') {
  //     print('************************** DACO ***********************');
  //   }
  //   if (word.trim() == 'growl') {
  //     print('************************** TACO ***********************');
  //   }
  // }
  // if (legalWords.contains('growl')) {
  //   print('growl is here!');
  // }

  print("Adding words to ${clusters.length} clusters");
  // int index = 0;
  for (String word in legalWords) {
    // Print a dot every 1000
    // if (index++ % 1000 == 0) stdout.write(".");
    // if (word.trim() == 'growl') {
    //   print('growl is here');
    // }

    // Could have cached this from first walk.
    List<String> wordLetters = word.trim().split("");
    // if (word.trim() == 'growl') {
    //   print('************************** GROWL ***********************');
    //   print(wordLetters);
    // }
    // TODO: reduce this or find how it can load async
    // Note: making this function a Future didn't seem to do it
    for (HoneygramLetterCluster cluster in clusters) {
      // if (word == 'growl') {
      //   print(cluster.letterSet);
      // }
      // 63% of time is spent in containsAll
      // Perhaps a walk of two sorted strings would be faster?
      if (cluster.letterSet.containsAll(wordLetters)) {
        // print('adding: $word');
        cluster.words.add(word);
      }
    }
  }
  // print('ding');
  await Future.delayed(const Duration(milliseconds: 100));
  // stdout.write("\n"); // End the series of dots.
  print('computer letter clusters done');

  return clusters;
}
