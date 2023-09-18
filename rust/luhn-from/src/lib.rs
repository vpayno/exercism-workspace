pub struct Luhn {
    code: String,
}

impl<T: ToString> From<T> for Luhn {
    fn from(input: T) -> Self {
        Self {
            code: input.to_string(),
        }
    }
}

impl Luhn {
    pub fn is_valid(&self) -> bool {
        match &self.code {
            code if code == "0" => false,
            code if code.is_empty() => false,
            code if !code.is_ascii() => false,
            code if !is_only_numbers_and_spaces(code) => false,
            _ => is_luhn_number(&self.code),
        }
    }
}

pub fn is_luhn_number(code: &str) -> bool {
    let digits: Vec<u32> = extract_digits_from_str_slice(code);

    let numbers = step_one_and_two(digits);

    let digit_sum: u32 = sum(numbers);

    (digit_sum % 10) == 0
}

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

pub fn sum(vector: Vec<u32>) -> u32 {
    vector.iter().sum()
}

pub fn extract_digits_from_str_slice(code: &str) -> Vec<u32> {
    code.chars()
        .filter(|x| x.is_ascii_digit())
        .map(|x| x.to_digit(10).unwrap())
        .rev()
        .collect()
}

pub fn is_only_numbers_and_spaces(code: &str) -> bool {
    for c in code.chars() {
        if !c.is_ascii_digit() && !c.is_whitespace() {
            return false;
        };
    }

    true
}
