use std::collections::HashSet;
use unicode_segmentation::UnicodeSegmentation;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let mut anagrams: HashSet<&'a str> = HashSet::new();

    let lc_word: String = word.to_lowercase().graphemes(true).collect();
    let mut vec_word: Vec<u16> = lc_word.encode_utf16().collect();
    vec_word.sort();

    let test_word: String = match String::from_utf16(&vec_word.clone()) {
        Ok(value) => value,
        Err(error) => {
            println!("falied to convert {:?} to a string: {}", vec_word, error);

            return anagrams.clone();
        }
    };

    let test_length = vec_word.len();

    println!("\ntest_word: {}", word);

    for candidate in possible_anagrams {
        let lc_candidate: String = candidate.to_lowercase().graphemes(true).collect();

        if lc_word.eq(&lc_candidate) {
            println!("{} == {} | skipping", lc_word, lc_candidate);
            continue;
        }

        let mut vec_candidate: Vec<u16> = lc_candidate.encode_utf16().collect();
        vec_candidate.sort();

        let test_candidate: String = match String::from_utf16(&vec_candidate.clone()) {
            Ok(value) => value,
            Err(error) => {
                panic!("{}", error);
            }
        };

        if test_length != vec_candidate.len() {
            continue;
        }

        println!(
            "test_word: {}\ttest_candidate: {}",
            test_word, test_candidate
        );

        if test_word.eq(&test_candidate) {
            println!("{} == {} | adding {}", test_word, test_candidate, candidate);
            anagrams.insert(*candidate);
        }

        println!();
    }

    println!("found anagrams: {:?}", anagrams);

    anagrams.clone()
}
