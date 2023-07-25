#include "scrabble_score.h"

namespace scrabble_score {

unsigned int score(std::string word) {
    unsigned int score{0};

    if (word.empty()) {
        return score;
    }

    const std::regex re_word("^[a-zA-Z]+$", std::regex_constants::egrep);
    if (!std::regex_search(word, re_word)) {
        return score;
    }

    const std::regex re_word_fixme("^.*[A-Z]+.*$", std::regex_constants::egrep);
    if (std::regex_search(word, re_word_fixme)) {
        auto lc_op = [](char rune) { return (char)tolower(rune); };

        std::transform(word.begin(), word.end(), word.begin(), lc_op);
    }

    for (auto letter : word) {
        switch (letter) {
        case 'd':
            [[fallthrough]];
        case 'g':
            score += 2;
            break;
        case 'b': // NOLINT(bugprone-branch-clone)
            [[fallthrough]];
        case 'c':
            [[fallthrough]];
        case 'm':
            [[fallthrough]];
        case 'p':
            score += 3;
            break;
        case 'f': // NOLINT(bugprone-branch-clone)
            [[fallthrough]];
        case 'h':
            [[fallthrough]];
        case 'v':
            [[fallthrough]];
        case 'w':
            [[fallthrough]];
        case 'y':
            score += 4;
            break;
        case 'k':
            score += 5;
            break;
        case 'j':
            [[fallthrough]];
        case 'x':
            score += 8;
            break;
        case 'q':
            [[fallthrough]];
        case 'z':
            score += 10;
            break;
        default:
            // A, E, I, O, U, L, N, R, S, T
            score += 1;
            break;
        }
    }

    return score;
}

} // namespace scrabble_score
