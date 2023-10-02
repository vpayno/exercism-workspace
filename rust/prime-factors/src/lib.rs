/// Computes list of prime factors for a given natural number.
///
/// Example
/// ```rust
/// use prime_factors::*;
///
/// let want: Vec<u64> = vec![2u64, 3, 5];
/// let got: Vec<u64> = factors(30);
///
/// assert_eq!(got, want);
/// ```
pub fn factors(n: u64) -> Vec<u64> {
    let mut factors: Vec<u64> = Vec::new();

    if n <= 1 {
        return factors;
    }

    if n == 2 {
        factors.push(2);
        return factors;
    }

    let mut factor;
    let mut number = n;

    factor = 2;
    while number % factor == 0 {
        number /= factor;
        factors.push(factor);
    }

    factor = 3;
    while number > 1 {
        while number % factor == 0 && number > 1 {
            number /= factor;
            factors.push(factor);
        }

        factor += 2;
    }

    factors
}
