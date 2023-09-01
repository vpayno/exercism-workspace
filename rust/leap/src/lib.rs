//! Exercise Url: <https://exercism.org/tracks/rust/exercises/leap>

/// is_leap_year determines if a year is a leap year.
///
/// Eample
/// ```rust
/// use leap::is_leap_year;
///
/// let mut want: bool;
/// let mut got: bool;
///
/// want = true;
/// got = is_leap_year(2_000);
/// assert_eq!(got, want);
///
/// want = false;
/// got = is_leap_year(1_800);
/// assert_eq!(got, want);
/// ```
pub fn is_leap_year(year: u64) -> bool {
    if year % 400 == 0 {
        return true;
    }

    if year % 100 == 0 {
        return false;
    }

    if year % 4 == 0 {
        return true;
    }

    false
}
