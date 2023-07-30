#include "protein_translation.h"

namespace protein_translation {

ProteinList proteins(RnaSequence rna_sequence) {
    // I would have called this proteins but the function name isn't
    // to_proteins.
    ProteinList result{};

    if (rna_sequence.empty()) {
        return result;
    }

    if (rna_sequence.length() % k_codon_length != 0) {
        return result;
    }

    if (rna_sequence.length() % k_codon_length != 0) {
        return result;
    }

    const std::string re_str{R"--((\w\w\w))--"};
    const std::regex re_exp(re_str);

    auto words_begin =
        std::sregex_iterator(rna_sequence.begin(), rna_sequence.end(), re_exp);
    auto words_end = std::sregex_iterator();

    // auto codon_count = std::distance(words_begin, words_end);

    for (auto i = words_begin; i != words_end; ++i) {
        auto match = *i;

        CodonSequence codon{match[0]};

        Proteins protein{};

        try {
            protein = k_codon_to_protein.at(match[1]);
        } catch (std::out_of_range &e) {

            return ProteinList{};
        }

        if (protein == Proteins::STOP) {
            break;
        }

        ProteinName protein_name;

        try {
            protein_name = k_protein_names.at(protein);
        } catch (std::out_of_range &e) {

            return ProteinList{};
        }

        result.emplace_back(protein_name);
    }

    return result;
}

} // namespace protein_translation
