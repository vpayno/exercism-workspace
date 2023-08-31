//! Exercise Url: <https://exercism.org/tracks/rust/exercises/gigasecond>

use time::Duration;

use time::PrimitiveDateTime as DateTime;

const GIGASECOND: i64 = 1_000_000_000;

/// Returns a DateTime one billion seconds after start.
///
/// Example
///
/// ```rust
/// use gigasecond::after;
/// use time::PrimitiveDateTime as DateTime;
/// use time::{Date,Time};
///
/// let want = DateTime::new(Date::from_calendar_date(2055, 5.try_into().unwrap(), 8).unwrap(), Time::from_hms(22, 43, 40).unwrap());
///
/// let dt = DateTime::new(Date::from_calendar_date(2023, 8.try_into().unwrap(), 30).unwrap(), Time::from_hms(20, 57, 00).unwrap());
/// let got = after(dt);
///
/// assert_eq!(got, want);
/// ```
pub fn after(start: DateTime) -> DateTime {
    start + Duration::seconds(GIGASECOND)
}
