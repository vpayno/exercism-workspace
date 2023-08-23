use std::collections::HashSet;

pub fn check(candidate: &str) -> bool {
    if candidate.is_empty() {
        return true;
    }

    /* this panics on these 3 tests
     * - test duplicated_character_in_the_middle ... FAILED (accentor)
     * - test one_duplicated_character ... FAILED (eleven)
     * - test one_duplicated_character_mixed_case ... FAILED (Alphabet)
     */
    /*
    let chars: HashSet<char> = candidate
        .to_lowercase()
        .chars()
        .filter(|x| x.is_alphabetic())
        .collect();
    */

    let mut chars: HashSet<char> = HashSet::new();

    for letter in candidate.to_lowercase().chars() {
        if letter.is_alphabetic() {
            if !chars.insert(letter) {
                return false;
            }
        }
    }

    true
}
