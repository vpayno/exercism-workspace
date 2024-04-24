class Pangram {
  bool isPangram(String text) {
    if (text.isEmpty | (text.length < 26)) {
      return false;
    }

    var letters = <String>{};
    letters = text
        .toLowerCase()
        .split('')
        .where((rune) => RegExp(r'^[a-z]$').hasMatch(rune))
        .toSet();

    return letters.length == 26;
  }
}
