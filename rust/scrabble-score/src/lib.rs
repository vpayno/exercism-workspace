/// Compute the Scrabble score for a word.

/// Scores a scrabble word.
///
/// ```rust
/// use scrabble_score::*;
///
/// let want: u64 = 87;
/// let got: u64 = score("abcdefghijklmnopqrstuvwxyz");
///
/// assert_eq!(got, want);
/// ```
pub fn score(word: &str) -> u64 {
    word.to_lowercase().trim().chars().map(score_letter).sum()
}

fn score_letter(letter: char) -> u64 {
    match letter {
        'a' | 'e' | 'i' | 'o' | 'u' | 'l' | 'n' | 'r' | 's' | 't' => 1,
        'd' | 'g' => 2,
        'b' | 'c' | 'm' | 'p' => 3,
        'f' | 'h' | 'v' | 'w' | 'y' => 4,
        'k' => 5,
        'j' | 'x' => 8,
        'q' | 'z' => 10,
        _ => 0,
    }
}
