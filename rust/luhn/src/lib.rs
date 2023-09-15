/// Check a Luhn checksum.
///
/// Example - test empty string
/// ```rust
/// use luhn::*;
///
/// let input: &str = "";
///
/// let want: bool = false;
/// let got: bool = luhn::is_valid(input);
///
/// assert_eq!(got, want);
/// ```
///
/// Example - test string with non-ascii char
/// ```rust
/// use luhn::*;
///
/// let input: &str = "123 ✓ 456";
///
/// let want: bool = false;
/// let got: bool = luhn::is_valid(input);
///
/// assert_eq!(got, want);
/// ```
///
/// Example - test string with ascii letter
/// ```rust
/// use luhn::*;
///
/// let input: &str = "123 a 456";
///
/// let want: bool = false;
/// let got: bool = luhn::is_valid(input);
///
/// assert_eq!(got, want);
/// ```
///
/// Example - valid input that's a luhn number
/// ```rust
/// use luhn::*;
///
/// let input: &str = "4539 3195 0343 6467";
///
/// let want: bool = true;
/// let got: bool = luhn::is_valid(input);
///
/// assert_eq!(got, want);
/// ```
///
/// Example - valid input that isn't a luhn number
/// ```rust
/// use luhn::*;
///
/// let input: &str = "8273 1232 7352 0569";
///
/// let want: bool = false;
/// let got: bool = luhn::is_valid(input);
///
/// assert_eq!(got, want);
/// ```
pub fn is_valid(code: &str) -> bool {
    match code.trim() {
        code if code == "0" => false,
        code if code.is_empty() => false,
        code if !code.is_ascii() => false,
        code if !is_only_numbers_and_spaces(code) => false,
        _ => is_luhn_number(code),
    }
}

/// Does the math on a checked input string to see if it's a valid luhn number.
///
/// Example - test if a number is a luhn number
/// ```rust
/// use luhn::*;
///
/// let input: &str = "4539 3195 0343 6467";
///
/// let want: bool = true;
/// let got: bool = luhn::is_luhn_number(input);
///
/// assert_eq!(got, want);
/// ```
///
/// Example - valid input that isn't a luhn number
/// ```rust
/// use luhn::*;
///
/// let input: &str = "8273 1232 7352 0569";
///
/// let want: bool = false;
/// let got: bool = luhn::is_luhn_number(input);
///
/// assert_eq!(got, want);
/// ```
pub fn is_luhn_number(code: &str) -> bool {
    let digits: Vec<u32> = extract_digits_from_str_slice(code);

    let numbers = step_one_and_two(digits);

    let digit_sum: u32 = sum(numbers);

    (digit_sum % 10) == 0
}

/// Performs the first and second steps of the luhn algorithm.
///
/// Example
/// ```rust
/// use luhn::*;
///
/// let input: &str = "4539 3195 0343 6467";
///
/// let want: Vec<u32> = vec![7,3,4,3,3,8,3,0,5,9,1,6,9,6,5,8];
/// let got: Vec<u32> = step_one_and_two(extract_digits_from_str_slice(input));
///
/// assert_eq!(got, want);
/// ```
pub fn step_one_and_two(mut vector: Vec<u32>) -> Vec<u32> {
    let mut i = 1;

    while i < vector.len() {
        vector[i] *= 2;

        if vector[i] > 9 {
            vector[i] -= 9;
        }

        i += 2;

        if i >= vector.len() {
            break;
        }
    }

    vector
}

/// Sums Vector of numbers.
///
/// Example
/// ```rust
/// use luhn::*;
///
/// let input: &str = "0 1234 5678 9";
///
/// let want: u32 = 45;
/// let got: u32 = luhn::sum(extract_digits_from_str_slice(input));
///
/// assert_eq!(got, want);
/// ```
///
/// Example
/// ```rust
/// use luhn::*;
///
/// let input: &str = "4539 3195 0343 6467";
/// let digits: Vec<u32> = step_one_and_two(extract_digits_from_str_slice(input));
///
/// let want: u32 = 80;
/// let got: u32 = luhn::sum(digits);
///
/// assert_eq!(got, want);
/// ```
pub fn sum(vector: Vec<u32>) -> u32 {
    vector.iter().sum()
}

/// Creates a reversed Vector of u32 from a string slice.
///
/// Example
/// ```rust
/// use luhn::*;
///
/// let input: &str = "1a2b 3c4d";
///
/// let want: Vec<u32> = vec![4,3,2,1];
/// let got: Vec<u32> = extract_digits_from_str_slice(input);
///
/// println!("want: {:?}\n", want);
/// println!(" got: {:?}\n", got);
///
/// assert!(got == want, "vectors aren't equal");
/// ```
pub fn extract_digits_from_str_slice(code: &str) -> Vec<u32> {
    code.chars()
        .filter(|x| x.is_ascii_digit())
        .map(|x| x.to_digit(10).unwrap())
        .rev()
        .collect()
}

/// Checks to see if string slice only has numbers and spaces.
///
/// Example
/// ```rust
/// use luhn::*;
///
/// let input: &str = "1234 5678 9";
///
/// let want: bool = true;
/// let got: bool = luhn::is_only_numbers_and_spaces(input);
///
/// assert_eq!(got, want);
/// ```
///
/// Example
/// ```rust
/// use luhn::*;
///
/// let input: &str = "1234 a678 9";
///
/// let want: bool = false;
/// let got: bool = luhn::is_only_numbers_and_spaces(input);
///
/// assert_eq!(got, want);
/// ```
pub fn is_only_numbers_and_spaces(code: &str) -> bool {
    for c in code.chars() {
        if !c.is_ascii_digit() && !c.is_whitespace() {
            return false;
        };
    }

    true
}
