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
    if span == 0 {
        // this corner case, with_zero_length, doesn't make sense
        return vec!["".to_string(); sequence.len() + 1];
    }

    if sequence.is_empty() {
        // why are we returning a vector with empty strings?
        return vec!["".to_string(); sequence.len()];
    }

    if sequence.len() == span {
        // this corner case makes sense
        return vec![sequence.to_string()];
    }

    // corner case ignored by tests
    if sequence.len() < span {
        return vec![];
    }

    // only one test to test the logic of the program?
    let mut groups: Vec<String> = vec![];
    let mut remaining: usize = sequence.len();

    for (index, _) in sequence.chars().enumerate() {
        if remaining < span || index + span > sequence.len() {
            break;
        }
        remaining -= 1;

        let group: String = sequence[index..span + index].to_string();

        groups.push(group);
    }

    groups
}
