#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

/// Convert a number between two bases.
///
/// A number is any slice of digits.
/// A digit is any unsigned integer (e.g. u8, u16, u32, u64, or usize).
/// Bases are specified as unsigned integers.
///
/// Return the corresponding Error enum if the conversion is impossible.
///
/// You are allowed to change the function signature as long as all test still pass.
///
/// Example:
/// Input
///   number: &[4, 2]
///   from_base: 10
///   to_base: 2
/// Result
///   Ok(vec![1, 0, 1, 0, 1, 0])
///
/// The example corresponds to converting the number 42 from decimal
/// which is equivalent to 101010 in binary.
///
/// Notes:
///  * The empty slice ( "[]" ) is equal to the number 0.
///  * Never output leading 0 digits, unless the input number is 0, in which the output must be `[0]`.
///    However, your function must be able to process input with leading 0 digits.
///
pub fn convert(input_digits: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    println!("input_digits: {:?}", input_digits);

    if from_base <= 1 {
        return Err(Error::InvalidInputBase);
    }

    if to_base <= 1 {
        return Err(Error::InvalidOutputBase);
    }

    if input_digits.is_empty() {
        return Ok(vec![0]);
    }

    for digit in input_digits {
        if *digit >= from_base {
            return Err(Error::InvalidDigit(*digit));
        }
    }

    // args: accumulator, element
    let base2ten_op = |mut base_ten: u32, digit: &u32| -> u32 {
        base_ten *= from_base;
        base_ten += digit;

        base_ten
    };

    let mut base_ten: u32 = input_digits.iter().fold(0, base2ten_op);

    println!("to base 10: {}", base_ten);

    let mut output_digits: Vec<u32> = Vec::new();

    if base_ten == 0 {
        output_digits.push(0);

        return Ok(output_digits);
    }

    while base_ten > 0 {
        output_digits.insert(0, base_ten % to_base);

        base_ten /= to_base;
    }

    println!("output_digits: {:?}", output_digits);

    Ok(output_digits)
}
