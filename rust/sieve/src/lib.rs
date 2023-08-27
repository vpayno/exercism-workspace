//! Exercise Url: <https://exercism.org/tracks/rust/exercises/sieve>

/// primes_up_to returns primes from 2 to number given.
///
/// Example
///
/// ```rust
/// use sieve::primes_up_to;
///
/// let want = [2, 3, 5, 7, 11, 13, 17, 19];
/// let got = primes_up_to(20);
///
/// assert_eq!(got, want);
/// ```
pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    let mut result = Vec::new();

    if upper_bound <= 1 {
        return result;
    }

    if upper_bound == 2 {
        result.push(2);

        return result;
    };

    let mut numbers: Vec<bool> = vec![true; (upper_bound + 1) as usize];

    // upper_bound has to be at least 3 to get here, we don't need to make sure these positions exist
    numbers[0] = false;
    numbers[1] = false;

    for (number, is_prime) in numbers.iter_mut().enumerate().skip(3) {
        if number % 2 == 0 {
            *is_prime = false;
        }
    }

    for number in 2..numbers.len() {
        if numbers[number] {
            let mut j: usize = 2;

            while number * j <= upper_bound as usize {
                let i: usize = number * j;
                numbers[i] = false;
                j += 1;
            }
        }
    }

    for (number, is_prime) in numbers.into_iter().enumerate() {
        if is_prime {
            result.push(number as u64);
        }
    }

    result
}
