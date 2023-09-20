/// Exercise Url: <https://exercism.org/tracks/rust/exercises/series>

/// Given a string of digits, output all the contiguous substrings of length n in that string in the order that they appear.
///
/// Not sure why we're not returning a Result here.
///
/// Example with a sequence of 5 digits and a span of 3:
/// ```rust
/// use series::*;
///
/// let want: Vec<String> = vec!["491".to_string(), "914".to_string(), "142".to_string()];
/// let got: Vec<String> = series("49142", 3);
///
/// assert_eq!(got, want);
/// ```
///
/// Example with a sequence of 5 digits and a span of 2:
/// ```rust
/// use series::*;
///
/// let want: Vec<String> = vec!["4914".to_string(), "9142".to_string()];
/// let got: Vec<String> = series("49142", 4);
///
/// assert_eq!(got, want);
/// ```
pub fn series(sequence: &str, span: usize) -> Vec<String> {
    match (sequence, span) {
        (_, span) if span == 0 => {
            // this corner case, with_zero_length, doesn't make sense, why isn't the data just an empty vector?
            vec!["".to_string(); sequence.len() + 1]
        }
        (sequence, span) if sequence.len() < span => {
            // corner case ignored by tests
            vec![]
        }
        (sequence, span) => sequence
            .chars()
            .collect::<Vec<char>>()
            .windows(span)
            .map(|x| x.iter().collect::<String>())
            .collect(),
    }
}
