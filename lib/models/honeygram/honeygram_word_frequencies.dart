// import 'package:corso_games_app/models/models.dart';

class HoneygramWordFrequencies {
  Map<String, int> wordToFrequency = <String, int>{};
  int maxFrequency = 0;
  int minFrequency = 999999999999;

  HoneygramWordFrequencies({
    required this.wordToFrequency,
  });

  // TODO: when is this used
  void wordFrequencies(List<String> lines) {
    print('word frequencies...');
    for (String line in lines) {
      // Format: word length frequency article_count
      List<String> parts = line.split(" ");
      String word = parts[0];
      int frequency = int.parse(parts[2]);
      wordToFrequency[word] = frequency;
      if (frequency > maxFrequency) maxFrequency = frequency;
      if (frequency < minFrequency) minFrequency = frequency;
    }
  }

  double rarityPercentile(String word) {
    // FIXME: Should this use minFrequency somewhere?
    int frequency = wordToFrequency[word] ?? 0;
    return 1.0 - (frequency / maxFrequency);
  }
}
