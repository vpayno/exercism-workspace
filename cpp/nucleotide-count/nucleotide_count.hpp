#if !defined(NUCLEOTIDE_COUNT_HPP)
#define NUCLEOTIDE_COUNT_HPP

#include <map>
#include <string>

namespace nucleotide_count {

using nucleotide_t = char;
using nucleotide_counts_t = std::map<nucleotide_t, int>; // size_t breaks tests
using dna_sequence_t = std::string;

nucleotide_counts_t count(dna_sequence_t dna_sequence);
bool is_valid_dna_sequence(dna_sequence_t dna_sequence);

} // namespace nucleotide_count

#endif // NUCLEOTIDE_COUNT_HPP
