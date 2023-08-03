// Find anagrams for a word from a list of candidates.
// https://exercism.org/tracks/dart/exercises/anagram

typedef word_t = String;
typedef letter_t = String;
typedef candidates_t = List<word_t>;
typedef matches_t = List<word_t>;
typedef letters_t = List<letter_t>;

class Anagram {
  matches_t findAnagrams(word_t search_word, candidates_t candidates) {
    matches_t matches = <String>[];
    letters_t search_letters = search_word.split('');
    search_letters.sort();
    word_t search_term = search_letters.join('');
    search_term.toLowerCase();

    var iter = candidates.iterator;

    while (iter.moveNext()) {
      letters_t letters = iter.toString().split('');
      letters.sort();
      word_t candidate = letters.join('');

      if (search_term == candidate) {
        matches.add(candidate);
      }
    }

    matches.sort();

    return matches;
  }
}
