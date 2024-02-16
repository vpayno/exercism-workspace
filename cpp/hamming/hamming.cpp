#include "hamming.hpp"
#include <iterator>
#include <stdexcept>

namespace hamming {

distance_t compute(dna_sequence_t lhs, dna_sequence_t rhs) {
    distance_t distance{0};

    if (lhs.empty()) {
        throw std::domain_error{"lhs DNA sequence can't be empty"};
    }

    if (rhs.empty()) {
        throw std::domain_error{"lhs DNA sequence can't be empty"};
    }

    if (lhs.length() != rhs.length()) {
        throw std::domain_error{
            "both DNA sequences have to be of the same length"};
    }

    auto rhs_iter = rhs.begin();

    for (auto lhs_iter : lhs) {
        const nucleotide_t lhs_nucleotide = lhs_iter;
        const nucleotide_t rhs_nucleotide = *rhs_iter;

        if (lhs_nucleotide != rhs_nucleotide) {
            distance += 1;
        }

        std::advance(rhs_iter, 1);
    }

    return distance;
}

} // namespace hamming
