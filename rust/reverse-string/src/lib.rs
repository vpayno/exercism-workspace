use unicode_segmentation::UnicodeSegmentation;

// https://docs.rs/unicode-segmentation/latest/unicode_segmentation/

pub fn reverse(input: &str) -> String {
    let reversed: String = input.graphemes(true).rev().collect();

    reversed
}
