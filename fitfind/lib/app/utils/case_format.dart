String kebabCaseToSentenceCase(String kebabCase) {
  List<String> words = kebabCase.split('-');
  List<String> capitalizedWords = words.map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    } else {
      return '';
    }
  }).toList();
  return capitalizedWords.join(' ');
}
