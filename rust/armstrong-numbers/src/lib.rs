pub fn is_armstrong_number(candidate: u32) -> bool {
    if candidate < 10 {
        return true;
    }

    let digit_count: usize = ((candidate as f64).log10() as usize) + 1;

    let mut num: u64 = candidate as u64;
    let mut pow_total: u64 = 0;

    while num > 0 {
        let pow_temp: u64 = num % 10;
        let mut pow_temp_total = 1;

        for _ in 0..digit_count {
            pow_temp_total *= pow_temp;
        }

        pow_total += pow_temp_total;
        num /= 10;
    }

    pow_total == (candidate as u64)
}
