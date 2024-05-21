class HoneygramLetterCluster {
  String letters;
  Set<String> letterSet;
  List<String> words = [];

  HoneygramLetterCluster({
    required this.letters,
  }) : letterSet = Set<String>.from(letters.split(''));
}
