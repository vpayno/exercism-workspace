//! Exercise Url: <https://exercism.org/tracks/rust/exercises/grains>

/// the chessboard square id minimum index
const INDEX_MIN: u32 = 1;
/// the chessboard square id maximum index
const INDEX_MAX: u32 = 64;

/// returns the number of grains on the specified square.
///
/// Example
///
/// ```rust
/// use grains::square;
///
/// let want = 9_223_372_036_854_775_808;
/// let got = square(64);
///
/// assert_eq!(got, want);
/// ```
pub fn square(index: u32) -> u64 {
    if !(INDEX_MIN..=INDEX_MAX).contains(&index) {
        // return 0_u64;
        panic!("Square must be between {} and {}", INDEX_MIN, INDEX_MAX);
    }

    (1_u64) << (index - 1)
}

/// returns all the grains on the chess board.
///
/// Example
///
/// ```rust
/// use grains::total;
///
/// let want = 18_446_744_073_709_551_615;
/// let got = total();
///
/// assert_eq!(got, want);
/// ```
pub fn total() -> u64 {
    // ((((1_u64) << 63) - 1) << 1) + 1
    // ((1_u128 << 64) - 1) as u64
    // u64::MAX
    // u64::max_value()
    // (1..=64).fold(0u64, |total, x| total + square(x as u32))

    (1..=INDEX_MAX).map(square).sum()
}
