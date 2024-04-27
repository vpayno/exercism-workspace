pub struct CodonsInfo<'a> {
    codons: std::collections::HashMap<&'a str, &'a str>,
}

const CODON_SIZE: usize = 3;

impl<'a> CodonsInfo<'a> {
    pub fn name_for(&self, codon: &str) -> Option<&'a str> {
        /*
        match codon {
            "AUG" => Some("methionine"),
            "UUU" | "UUC" => Some("phenylalanine"),
            "UUA" | "UUG" => Some("leucine"),
            "UCU" | "UCC" | "UCA" | "UCG" => Some("serine"),
            "UAU" | "UAC" => Some("tyrosine"),
            "UGU" | "UGC" => Some("cysteine"),
            "UGG" => Some("tryptophan"),
            "UAA" | "UAG" | "UGA" => Some("stop codon"),
            _ => Some("stop codon"),
        }
        */

        self.codons.get(codon).cloned()
    }

    pub fn of_rna(&self, rna: &str) -> Option<Vec<&'a str>> {
        // to byte slice, return 3 bytes, convert the bytes to string,
        // convert codon to protein, return a vector of Options
        rna.as_bytes()
            .chunks(CODON_SIZE)
            .map(std::str::from_utf8)
            .map(|result_utf8| self.name_for(result_utf8.unwrap()))
            .take_while(|&option_codon| option_codon != Some("stop codon"))
            .collect()
    }
}

pub fn parse<'a>(pairs: Vec<(&'a str, &'a str)>) -> CodonsInfo<'a> {
    CodonsInfo {
        // collect the key value pairs, copy them, convert them to a hashmap
        codons: pairs.iter().cloned().collect(),
    }
}
