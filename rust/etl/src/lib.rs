use std::collections::BTreeMap;

pub fn transform(old_format: &BTreeMap<i32, Vec<char>>) -> BTreeMap<char, i32> {
    let mut new_format: BTreeMap<char, i32> = BTreeMap::new();

    for (score, letters) in old_format {
        for letter in letters {
            new_format.insert(letter.to_ascii_lowercase(), *score);
        }
    }

    new_format
}
