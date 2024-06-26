#include <cstddef>
#if !defined(HAMMING_HPP)
#define HAMMING_HPP

#include <string>

namespace hamming {

using distance_t = size_t;
using dna_sequence_t = std::string;
using nucleotide_t = char;

distance_t compute(dna_sequence_t lhs, dna_sequence_t rhs);

} // namespace hamming

#endif // HAMMING_HPP
