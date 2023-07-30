#include "rna_transcription.hpp"

namespace rna_transcription {

bool is_valid_dna_sequence(dna_sequence_t dna_sequence) {
    const std::regex re_dna("^(|[ACGT]+)$", std::regex_constants::egrep);

    return std::regex_search(dna_sequence, re_dna);
}

nucleotide_t to_rna(nucleotide_t dna_nucleotide) {
    return k_dna_to_rna.at(dna_nucleotide);
}

rna_sequence_t to_rna(dna_sequence_t dna_sequence) {
    rna_sequence_t rna_sequence{};

    if (dna_sequence.length() == 0) {
        return rna_sequence;
    }

    if (!is_valid_dna_sequence(dna_sequence)) {
        return rna_sequence;
    }

    for (auto iter : dna_sequence) {
        const nucleotide_t dna_nucleotide{iter};

        const nucleotide_t rna_nucleotide{to_rna(dna_nucleotide)};

        rna_sequence.push_back(rna_nucleotide);
    }

    return rna_sequence;
}

} // namespace rna_transcription
