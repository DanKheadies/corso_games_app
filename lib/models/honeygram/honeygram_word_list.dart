// // import 'dart:io';

// import 'package:corso_games_app/models/models.dart';

// class HoneygramWordList {
//   // final List<String> allWords;
//   // final List<String> legalWords;

//   // late final Future<List<HoneygramLetterCluster>> letterClusters =
//   //     computeLetterClusters();

//   HoneygramWordList({
//     // required this.allWords,
//   });
//   // : legalWords = allWords.where(isLegalWord).toList();

//   static bool isLegalWord(String word) {
//     // Also exclude words with S in them?
//     // https://nytbee.com/ suggests S is not allowed.
//     // https://nytbee.com/ suggests NYT never goes above 80 words!
//     // return (word.length >= 4 && !word.contains('s'));

//     if (word == 'lost') {
//       print('lost is here');
//     }
//     return (word.length >= 4);
//   }

//   // TODO: this should only run "once" and if we can have a dart file
//   // with a List of HoneygramLetterClusters g2g BEFORE the user opens
//   // the game, that's all the better. Shit takes like a minute to load.
//   Future<List<HoneygramLetterCluster>> computeLetterClusters({
//     required List<String> wordList,
//   }) async {
//     print('Getting legal words..');
//     List<String> legalWords = wordList.where(isLegalWord).toList();
//     print("Creating clusters from ${legalWords.length} legal words");
//     await Future.delayed(const Duration(milliseconds: 100));
//     Set<String> letterSets = {};

//     // print('testicles..');
//     // String testicles = 'testicles';
//     // Set<String> testSets = {};
//     // print(testSets);
//     // testSets.add('testicool');
//     // print(testSets);
//     // testSets.add(testicles);
//     // print(testSets);

//     // print('testicle..');
//     // String testicle = 'testicle';
//     // List<String> splitTesticle = testicle.split("");
//     // print(splitTesticle);
//     // List<String> testicleSet = List.from(
//     //   Set.from(
//     //     testicle.split(""),
//     //   ),
//     // );
//     // print(testicleSet);
//     // print(testicleSet.length);

//     // String testicool = 'testicool';
//     // List<String> splitTesticool = testicool.split("");
//     // print(splitTesticool);
//     // List<String> testicoolSet = List.from(
//     //   Set.from(
//     //     testicool.split(""),
//     //   ),
//     // );
//     // print(testicoolSet);
//     // print(testicoolSet.length);

//     print('help');
//     List<String> derp = ['testicool', 'oarlike'];
//     for (int i = 0; i <= 1; i++) {
//       List<String> letters = List.from(
//         Set.from(
//           derp[i].split(""),
//         ),
//       );
//       print(letters.length);
//       print(letters);
//       if (letters.length != 7) continue;
//       print('carry on');
//       letters.sort();
//       letterSets.add(letters.join(""));
//       print(letters);
//       print(letterSets);
//     }

//     // print('first legalword: ${legalWords[0]}');
//     // print('10th legalword: ${legalWords[9]}');
//     // print('100th legalword: ${legalWords[99]}');
//     // for (String word in legalWords) {
//     //   // if (word.length == 7) {
//     //   //   List<String> letters = List.from(
//     //   //     Set.from(
//     //   //       word.split(""),
//     //   //     ),
//     //   //   );
//     //   //   // if (letters.length != 7) continue;
//     //   //   // letters.sort();
//     //   //   // letterSets.add(letters.join(""));
//     //   //   // if (letters.length == 7) {
//     //   //   // print(letters);
//     //   //   letters.sort();
//     //   //   // print(letters);
//     //   //   letterSets.add(letters.join(""));
//     //   //   // }
//     //   // }
//     //   List<String> letters = List.from(
//     //     Set.from(
//     //       word.split(""),
//     //     ),
//     //   );
//     //   if (letters.length != 7) continue;
//     //   letters.sort();
//     //   letterSets.add(letters.join(""));
//     // }
//     // TODO: reactivate step above
//     print('haz list of strings / words');
//     // print('letterSet: ${letterSets.first}');
//     print('wtf:');
//     print(letterSets.first);
//     print('letterSet #: ${letterSets.length}');

//     // TODO: center not being set
//     // Update: we're losing a letter from the set, and it's not being saved
//     // as the center, i.e. it gets "saved" as the center later
//     List<HoneygramLetterCluster> clusters = [];
//     // clusters contain:
//     // a string of letters
//     // a set of letters / strings (letterSet)
//     // a list of words / strings
//     for (String letters in letterSets) {
//       clusters.add(
//         HoneygramLetterCluster(
//           letters: letters,
//         ),
//       );
//     }
//     print('first cluster:');
//     print(clusters[0].letters); // this should be 7 letters
//     print(clusters[0].letterSet); // 6 letters seperated by commas w/ } at end
//     print(clusters[0].words); // empty here

//     print('second cluster:');
//     print(clusters[1].letters); // this should be 7 letters
//     print(clusters[1].letterSet); // 6 letters seperated by commas w/ } at end
//     print(clusters[1].words); // empty here

//     // String derpCenter = clusters[0].letterSet.first;
//     // print(derpCenter);
//     // for (String center in clusters[0].letterSet) {
//     //   print('in the computer');
//     //   print(center);
//     // }

//     print("Adding words to ${clusters.length} clusters");
//     // int index = 0;
//     for (String word in legalWords) {
//       // Print a dot every 1000
//       // if (index++ % 1000 == 0) stdout.write(".");
//       if (word == 'lost') {
//         print('lost is here');
//       }

//       // Could have cached this from first walk.
//       List<String> wordLetters = word.split("");
//       if (word == 'lost') {
//         print(wordLetters);
//       }
//       // TODO: reduce this or find how it can load async
//       // Note: making this function a Future didn't seem to do it
//       for (HoneygramLetterCluster cluster in clusters) {
//         if (word == 'lost') {
//           print(cluster.letterSet);
//         }
//         // 63% of time is spent in containsAll
//         // Perhaps a walk of two sorted strings would be faster?
//         if (cluster.letterSet.containsAll(wordLetters)) {
//           print('adding: $word');
//           cluster.words.add(word);
//         }
//       }
//     }
//     // print('ding');
//     await Future.delayed(const Duration(milliseconds: 100));
//     // stdout.write("\n"); // End the series of dots.
//     print('computer letter clusters done');

//     return clusters;
//   }
// }
