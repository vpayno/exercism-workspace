fn get_success_rate(speed: u8) -> f64 {
    //  1-4: 100% success rate
    //  5-8:  90% success rate
    // 9-10:  77% success rate
    let result: f64 = match speed {
        1..=4 => 1.00,
        5..=8 => 0.90,
        9..=10 => 0.77,
        _ => 0.0,
    };

    // I know I could just return from the match statement but this is more obvious.
    result
}

pub fn production_rate_per_hour(speed: u8) -> f64 {
    let cars_per_hour: i64 = 221;
    let rate: f64 = get_success_rate(speed) * speed as f64 * cars_per_hour as f64;

    rate
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    let result: u32 = production_rate_per_hour(speed) as u32 / 60;

    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_get_success_rate() {
        let speeds = vec![1, 5, 9, 88];
        let wants = vec![1.0, 0.9, 0.77, 0.0];

        for it in speeds.iter().zip(wants.iter()) {
            let (speed, want) = it;
            let got: f64 = get_success_rate(*speed);
            assert_eq!(got, *want);
        }
    }
}
