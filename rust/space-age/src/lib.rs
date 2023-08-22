//! Project URL: <https://exercism.org/tracks/rust/exercises/space-age>

const SECONDS_IN_EARTH_YEAR: f64 = 365.25 * 24.0 * 60.0 * 60.0;

#[derive(Debug)]
/// Duration struct contains the planet's orbital period in earth seconds.
pub struct Duration {
    age_in_seconds: f64,
}

impl From<u64> for Duration {
    /// from returns the planet's orbital period.
    fn from(seconds: u64) -> Self {
        Duration {
            age_in_seconds: (seconds as f64) / (SECONDS_IN_EARTH_YEAR),
        }
    }
}

/// Planet trait declares the orbital_period method and calculates a person's age on a given planet.
pub trait Planet {
    fn orbital_period() -> f64;

    fn years_during(duration: &Duration) -> f64 {
        duration.age_in_seconds / Self::orbital_period()
    }
}

generate_planet!(Mercury, 0.2408467);
generate_planet!(Venus, 0.61519726);
generate_planet!(Earth, 1.0);
generate_planet!(Mars, 1.8808158);
generate_planet!(Jupiter, 11.862615);
generate_planet!(Saturn, 29.447498);
generate_planet!(Uranus, 84.016846);
generate_planet!(Neptune, 164.79132);

/// generate_planet macro creates duplicate boiler plate (the planet structs and Planet implementations).
/// # Examples
///
/// ```rust
/// # #[macro_use]
/// # use generate_planet;
/// # use space_age::*;
///
/// # fn main() {
/// generate_planet!(Pluto, 90_560.0/365.25);
///
/// let duration = Duration::from(3_000_000_000);
///
/// let got = Pluto::years_during(&duration);
///
/// let want = 0.38341676482135845;
///
/// assert_eq!(got, want);
/// # }
/// ```
// https://blog.logrocket.com/macros-in-rust-a-tutorial-with-examples/
#[macro_export]
macro_rules! generate_planet {
    ($planet:ident, $period:expr) => {
        pub struct $planet;

        impl Planet for $planet {
            fn orbital_period() -> f64 {
                $period
            }
        }
    };
}
