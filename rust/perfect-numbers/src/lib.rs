#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

/// Determine if a number is perfect, abundant or deficient based on Nicomachus' (60 - 120 CE) classification scheme for positive integers.
///
/// Example - Invalid Input
/// ```rust
/// use perfect_numbers::*;
///
/// let want: Option<Classification> = None;
///
/// match classify(0) {
///     Some(got) => { assert!(false); }
///     None => { assert!(true) },
/// };
/// ```
///
/// Example - Perfect
/// ```rust
/// use perfect_numbers::*;
///
/// let want: Classification = Classification::Perfect;
///
/// match classify(6) {
///     Some(got) => { assert_eq!(got, want); }
///     None => {},
/// };
/// ```
///
/// Example - Abundant
/// ```rust
/// use perfect_numbers::*;
///
/// let want: Classification = Classification::Abundant;
///
/// match classify(12) {
///     Some(got) => { assert_eq!(got, want); }
///     None => {},
/// };
/// ```
///
/// Example - Deficient
/// ```rust
/// use perfect_numbers::*;
///
/// let want: Classification = Classification::Deficient;
///
/// match classify(8) {
///     Some(got) => { assert_eq!(got, want); }
///     None => {},
/// };
/// ```
pub fn classify(number: u64) -> Option<Classification> {
    if number == 0 {
        return None;
    }

    let mut factors: Vec<u64> = Vec::new();

    let mut factor: u64 = 1;

    while factor < number {
        if number % factor == 0 {
            factors.push(factor);
        }

        factor += 1;
    }

    let aliquot_sum: u64 = factors.iter().sum();

    Some(match aliquot_sum {
        sum if sum > number => Classification::Abundant,
        sum if sum < number => Classification::Deficient,
        _ => Classification::Perfect,
    })
}
