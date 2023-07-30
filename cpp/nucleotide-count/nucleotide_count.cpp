#include "nucleotide_count.hpp"

namespace nucleotide_count {

nucleotide_counts_t count(dna_sequence_t dna_sequence) {
    nucleotide_counts_t counts{
        std::make_pair('A', 0),
        std::make_pair('C', 0),
        std::make_pair('G', 0),
        std::make_pair('T', 0),
    };

    if (dna_sequence.length() == 0) {
        return counts;
    }

    if (!is_valid_dna_sequence(dna_sequence)) {
        throw std::invalid_argument{"dna sequence contains invalid data"};
    }

    for (auto iter : dna_sequence) {
        counts[iter] += 1;
    }

    return counts;
}

bool is_valid_dna_sequence(dna_sequence_t dna_sequence) {
    // why is an empty string valid input?
    const std::regex re_dna("^(|[ACGT]+)$", std::regex_constants::egrep);

    return std::regex_search(dna_sequence, re_dna);
}

} // namespace nucleotide_count
