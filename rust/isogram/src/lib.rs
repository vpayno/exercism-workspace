//! Project Url: <https://exercism.org/tracks/rust/exercises/isogram/dig_deeper>

use std::collections::HashSet;

/// Example
///
/// ```rust
/// use isogram::check;
///
/// let word = "eleven";
/// let got = check(word);
///
/// println!("Is {} an isogram? {}", word, got);
/// ```
pub fn check(candidate: &str) -> bool {
    if candidate.is_empty() {
        return true;
    }

    // using u8 instead of char allows support of utf-8 charcaters, not tested by tests :(
    let mut chars: HashSet<u8> = HashSet::new();

    // The panics are handled by using the result of this chain.
    // insert() returns false when a duplicate is detected
    // all() returns false if one of the iterations was false
    // inspect() let's us run an arbitrary command on each item
    // filter() filters non a-z characters
    // chars() returns an iterator to the characters in the string
    // to_lowercase() converts the string to lowercase (could also use .map() to convert each individual character)
    candidate
        .to_lowercase()
        .bytes()
        .filter(|rune| rune.is_ascii_alphabetic())
        .inspect(|rune| println!("rune: {}", rune))
        .all(|rune| chars.insert(rune))
}

/*
#[test]
fn test_empty() {
    assert!(check(""), "Empty word is an isogram.")
}

#[test]
fn test_one() {
    assert!(
        check("one"),
        "Word without duplicate letters is an isogram."
    )
}

#[test]
fn test_eleven() {
    assert!(
        !check("eleven"),
        "Word with duplicate letters isn't an isogram."
    )
}

#[test]
fn test_numbers() {
    assert!(
        check("123a456b789"),
        "Word with numbers and without duplicate letters isn't an isogram."
    )
}
*/
