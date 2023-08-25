//! Exercism Url: <https://exercism.org/tracks/rust/exercises/roman-numerals>

use std::collections::BTreeMap;
use std::fmt::{Display, Formatter, Result};

/// Example
///
/// ```rust
/// use roman_numerals::Roman;
///
/// let want ="MCCXXXIV";
/// let got = Roman::from(1234).to_string();
///
/// assert_eq!(got, want);
/// ```
pub struct Roman(u32);

impl Display for Roman {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        let mut number = self.0;

        // can't declare this as a global const
        let mut decimal_to_roman: BTreeMap<u32, String> = BTreeMap::new();
        decimal_to_roman.insert(1, "I".to_owned());
        decimal_to_roman.insert(4, "IV".to_owned());
        decimal_to_roman.insert(5, "V".to_owned());
        decimal_to_roman.insert(9, "IX".to_owned());
        decimal_to_roman.insert(10, "X".to_owned());
        decimal_to_roman.insert(40, "XL".to_owned());
        decimal_to_roman.insert(50, "L".to_owned());
        decimal_to_roman.insert(90, "XC".to_owned());
        decimal_to_roman.insert(100, "C".to_owned());
        decimal_to_roman.insert(400, "CD".to_owned());
        decimal_to_roman.insert(500, "D".to_owned());
        decimal_to_roman.insert(900, "CM".to_owned());
        decimal_to_roman.insert(1_000, "M".to_owned());

        // iterate over vector backwards
        for pair in decimal_to_roman.iter().rev() {
            let (key, value) = pair;

            // keep using the roman numeral until it doesn't "fit"
            while number >= *key {
                // start writing roman numberals to formatter
                match f.write_str(value.as_str()) {
                    Ok(ok) => ok,
                    Err(e) => panic!("failed to write: {:?}", e),
                };

                // decrement decimal number
                number -= key;
            }
        }

        Ok(())
    }
}

impl From<u32> for Roman {
    fn from(num: u32) -> Self {
        Self(num)
    }
}
