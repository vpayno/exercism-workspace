//! Exercise Url: <https://exercism.org/tracks/rust/exercises/acronym>

/// abbreviate function returns the acronym from a string.
///
/// # Examples
/// ```rust
/// use acronym::abbreviate;
///
/// let want = "ABC";
/// let got = abbreviate("Apple Banana Cranberries");
///
/// assert_eq!(got, want);
/// ```
pub fn abbreviate(phrase: &str) -> String {
    let tmp_str = phrase.replace(&['-', '_'][..], " ");

    let mut acronym = String::new();

    for word in tmp_str.split_whitespace() {
        // I refuse to get in the bad habit of using .unwrap()!
        acronym.push(match word.to_uppercase().chars().next().ok_or(' ') {
            Ok(letter) => letter,
            Err(error) => panic!("Problem getting the first letter in word: {:?}", error),
        });

        // take_next flags capital letters in a word if it's preceded by at least one lowercase letter.
        let mut take_next = false;
        // Already grabbed the first letter of the word so the slice doesn't contain it.
        for letter in word[1..].chars() {
            if letter.is_lowercase() {
                take_next = true;
                continue;
            }

            if letter.is_uppercase() && take_next {
                acronym.push(letter);
                take_next = false;
            }
        }
    }

    acronym
}
