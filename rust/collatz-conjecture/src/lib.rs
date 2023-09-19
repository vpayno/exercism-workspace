pub fn collatz(start: u64) -> Option<u64> {
    match start {
        0 => None,
        1 => Some(0),
        num if num % 2 == 0 => collatz(num / 2).map(|count| count + 1),
        num => collatz(num.checked_mul(3)?.checked_add(1)?).map(|count| count + 1),
    }
}
