// Given a word, compute the Scrabble score for that word.
// https://exercism.org/tracks/dart/exercises/scrabble-score

// letterScore(String) returns the score of the letter
int letterScore(String letter) {
  letter = letter.toLowerCase();

  switch (letter) {
    case 'd':
    case 'g':
      return 2;
    case 'b':
    case 'c':
    case 'm':
    case 'p':
      return 3;
    case 'f':
    case 'h':
    case 'v':
    case 'w':
    case 'y':
      return 4;
    case 'k':
      return 5;
    case 'j':
    case 'x':
      return 8;
    case 'q':
    case 'z':
      return 10;
    default:
      // A, E, I, O, U, L, N, R, S, T
      return 1;
  }
}

// score(String) returns the score of the word
int score(String word) {
  word = word.toLowerCase();

  var result = 0;
  var letters = word.split('');

  for (final letter in letters) {
    result += letterScore(letter);
  }

  return result;
}
