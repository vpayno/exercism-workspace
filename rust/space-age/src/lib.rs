const SECONDS_IN_EARTH_YEAR: f64 = 365.25 * 24.0 * 60.0 * 60.0;

#[derive(Debug)]
pub struct Duration {
    age_in_years: f64,
}

impl From<u64> for Duration {
    fn from(seconds: u64) -> Self {
        Duration {
            age_in_years: (seconds as f64) / (SECONDS_IN_EARTH_YEAR),
        }
    }
}

pub trait Planet {
    fn orbital_period() -> f64;

    fn years_during(duration: &Duration) -> f64 {
        duration.age_in_years / Self::orbital_period()
    }
}

pub struct Mercury;
pub struct Venus;
pub struct Earth;
pub struct Mars;
pub struct Jupiter;
pub struct Saturn;
pub struct Uranus;
pub struct Neptune;

impl Planet for Mercury {
    fn orbital_period() -> f64 {
        0.2408467
    }
}

impl Planet for Venus {
    fn orbital_period() -> f64 {
        0.61519726
    }
}

impl Planet for Earth {
    fn orbital_period() -> f64 {
        1.0
    }
}

impl Planet for Mars {
    fn orbital_period() -> f64 {
        1.8808158
    }
}

impl Planet for Jupiter {
    fn orbital_period() -> f64 {
        11.862615
    }
}

impl Planet for Saturn {
    fn orbital_period() -> f64 {
        29.447498
    }
}

impl Planet for Uranus {
    fn orbital_period() -> f64 {
        84.016846
    }
}

impl Planet for Neptune {
    fn orbital_period() -> f64 {
        164.79132
    }
}
