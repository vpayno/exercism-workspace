#if !defined(RNA_TRANSCRIPTION_HPP)
#define RNA_TRANSCRIPTION_HPP

#include <map>
#include <regex>
#include <string>

namespace rna_transcription {

using dna_sequence_t = std::string;
using rna_sequence_t = std::string;
using nucleotide_t = char;
using dna_to_rna_t = std::map<nucleotide_t, nucleotide_t>;

const dna_to_rna_t k_dna_to_rna = {
    std::make_pair('G', 'C'),
    std::make_pair('C', 'G'),
    std::make_pair('T', 'A'),
    std::make_pair('A', 'U'),
};

bool is_valid_dna_sequence(dna_sequence_t dna_sequence);
nucleotide_t to_rna(nucleotide_t dna_nucleotide);
rna_sequence_t to_rna(dna_sequence_t dna_sequence);

} // namespace rna_transcription

#endif // RNA_TRANSCRIPTION_HPP
