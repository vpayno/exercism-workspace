//! Exercise Url: <https://exercism.org/tracks/rust/exercises/raindrops>

/// raindrops generates rain sounds from a number.
pub fn raindrops(number: u32) -> String {
    let mut sounds = String::new();

    if number % 3 == 0 {
        sounds += "Pling";
    }

    if number % 5 == 0 {
        sounds += "Plang";
    }

    if number % 7 == 0 {
        sounds += "Plong";
    }

    if sounds.is_empty() {
        sounds += number.to_string().as_str();
    }

    sounds
}
