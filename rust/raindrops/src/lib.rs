//! Exercise Url: <https://exercism.org/tracks/rust/exercises/raindrops>

/// raindrops generates rain sounds from a number.
///
/// # Examples
/// ```rust
/// use raindrops::raindrops;
///
/// let mut got : String;
/// let mut want : String;
///
/// got = raindrops(3);
/// want = "Pling".to_string();
/// assert_eq!(got, want);
///
/// got = raindrops(5);
/// want = "Plang".to_string();
/// assert_eq!(got, want);
///
/// got = raindrops(7);
/// want = "Plong".to_string();
/// assert_eq!(got, want);
///
/// got = raindrops(105);
/// want = "PlingPlangPlong".to_string();
/// assert_eq!(got, want);
///
/// got = raindrops(11);
/// want = "11".to_string();
/// assert_eq!(got, want);
/// ```
pub fn raindrops(number: u32) -> String {
    let mut sounds = String::new();

    if number % 3 == 0 {
        sounds.push_str("Pling");
    }

    if number % 5 == 0 {
        sounds.push_str("Plang");
    }

    if number % 7 == 0 {
        sounds.push_str("Plong");
    }

    if sounds.is_empty() {
        sounds.push_str(number.to_string().as_str());
    }

    sounds
}
