use luhn::*;

fn main() {
    let input: &str = "4539 3195 0343 6467";

    println!("is empty: {}\n", input.is_empty());

    println!("is ascii: {}\n", input.is_ascii());

    println!("is correct: {}\n", is_only_numbers_and_spaces(input));

    let clean: Vec<u32> = extract_digits_from_str_slice(input);

    println!("  clean: {:?}\n", clean);

    let updated: Vec<u32> = step_one_and_two(clean);

    println!("updated: {:?}\n", updated);

    let digit_sum: u32 = sum(updated);

    println!("valid: {}\n", digit_sum % 80 == 0);

    println!("valid: {}\n", is_valid(input));
}
