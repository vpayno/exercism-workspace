//! Exercise Url: <https://exercism.org/tracks/rust/exercises/difference-of-squares>

/// Find the square of a sum of numbers.
///
/// Example
/// ```rust
/// use difference_of_squares::*;
///
/// let want: u32 = 25_502_500;
/// let got: u32 = square_of_sum(100);
///
/// assert_eq!(got, want);
/// ```
pub fn square_of_sum(number: u32) -> u32 {
    u32::pow(number * (number + 1) / 2, 2)
}

/// Find the sum of square numbers.
///
/// Example
/// ```rust
/// use difference_of_squares::*;
///
/// let want: u32 = 338_350;
/// let got: u32 = sum_of_squares(100);
///
/// assert_eq!(got, want);
/// ```
pub fn sum_of_squares(number: u32) -> u32 {
    number * (number + 1) * (2 * number + 1) / 6
}

/// Find difference of squares.
///
/// Example
/// ```rust
/// use difference_of_squares::*;
///
/// let want: u32 = square_of_sum(100) - sum_of_squares(100);
/// let got: u32 = difference(100);
///
/// assert_eq!(got, want);
/// ```
pub fn difference(number: u32) -> u32 {
    square_of_sum(number) - sum_of_squares(number)
}
