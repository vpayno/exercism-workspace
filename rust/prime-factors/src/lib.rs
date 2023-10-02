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
