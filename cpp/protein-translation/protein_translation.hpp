#include <cstddef>
#include <utility>
#if !defined(PROTEIN_TRANSLATION_HPP)
#define PROTEIN_TRANSLATION_HPP

#include <map>
#include <string>
#include <vector>

enum class Proteins {
    Methionine,
    Phenylalanine,
    Leucine,
    Serine,
    Tyrosine,
    Cysteine,
    Tryptophan,
    STOP,
};

// Sequence -> String
// List -> Vector

using ProteinName = std::string;
using RnaSequence = std::string;
using CodonSequence = std::string;
using CodonList = std::vector<CodonSequence>;
using ProteinList = std::vector<ProteinName>;
using ProteinNames = std::map<Proteins, ProteinName>;
using CodonToProtein = std::map<CodonSequence, Proteins>;

const size_t k_codon_length = 3;

const ProteinNames k_protein_names = {
    std::make_pair(Proteins::Methionine, "Methionine"),
    std::make_pair(Proteins::Phenylalanine, "Phenylalanine"),
    std::make_pair(Proteins::Leucine, "Leucine"),
    std::make_pair(Proteins::Serine, "Serine"),
    std::make_pair(Proteins::Tyrosine, "Tyrosine"),
    std::make_pair(Proteins::Cysteine, "Cysteine"),
    std::make_pair(Proteins::Tryptophan, "Tryptophan"),
    std::make_pair(Proteins::STOP, "STOP"),
};

const CodonToProtein k_codon_to_protein = {
    std::make_pair("AUG", Proteins::Methionine),
    std::make_pair("UUU", Proteins::Phenylalanine),
    std::make_pair("UUC", Proteins::Phenylalanine),
    std::make_pair("UUA", Proteins::Leucine),
    std::make_pair("UUG", Proteins::Leucine),
    std::make_pair("UCU", Proteins::Serine),
    std::make_pair("UCC", Proteins::Serine),
    std::make_pair("UCA", Proteins::Serine),
    std::make_pair("UCG", Proteins::Serine),
    std::make_pair("UAU", Proteins::Tyrosine),
    std::make_pair("UAC", Proteins::Tyrosine),
    std::make_pair("UGU", Proteins::Cysteine),
    std::make_pair("UGC", Proteins::Cysteine),
    std::make_pair("UGG", Proteins::Tryptophan),
    std::make_pair("UAA", Proteins::STOP),
    std::make_pair("UAG", Proteins::STOP),
    std::make_pair("UGA", Proteins::STOP),
};

namespace protein_translation {

ProteinList proteins(RnaSequence rna_sequence);

} // namespace protein_translation

#endif // PROTEIN_TRANSLATION_HPP
