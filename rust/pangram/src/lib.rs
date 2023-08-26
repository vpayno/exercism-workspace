//! Exercise Url: <https://exercism.org/tracks/rust/exercises/pangram>

/// Determine whether a sentence is a pangram.
///
/// Example
///
/// ```rust
/// use pangram::is_pangram;
///
/// let mut want : bool;
/// let mut got : bool;
///
/// want = true;
/// got = is_pangram("abcdefghikjlmnopqrstuvwxyz");
/// assert_eq!(got, want);
///
/// want = false;
/// got = is_pangram("hello");
/// assert_eq!(got, want);
/// ```
pub fn is_pangram(sentence: &str) -> bool {
    // handle corner cases first
    if sentence.is_empty() {
        return false;
    }

    if sentence.len() < 26 {
        return false;
    }

    // dump chars into set
    let letters: std::collections::HashSet<char> = std::collections::HashSet::from_iter(
        sentence
            .to_lowercase()
            .chars()
            .filter(|rune| rune.is_ascii_alphabetic()),
    );

    println!("sentence: [{:?}]", sentence);
    println!(" letters: [{:?}]", letters);

    // does set have 26 letters
    letters.len() >= 26
}
