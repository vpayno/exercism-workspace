#if !defined(NUCLEOTIDE_COUNT_H)
#define NUCLEOTIDE_COUNT_H

// This isn't a valid C++ header file (should be nucleotide_count.hpp).

#include <map>
#include <regex>
#include <stdexcept>
#include <string>

namespace nucleotide_count {

using nucleotide_t = char;
using nucleotide_counts_t = std::map<nucleotide_t, int>; // size_t breaks tests
using dna_sequence_t = std::string;

nucleotide_counts_t count(dna_sequence_t dna_sequence);
bool is_valid_dna_sequence(dna_sequence_t dna_sequence);

} // namespace nucleotide_count

#endif // NUCLEOTIDE_COUNT_H
