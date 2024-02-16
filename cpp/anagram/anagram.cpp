#include "anagram.hpp"
#include <algorithm>
#include <cctype>
#include <iterator>
#include <string>
#include <vector>

namespace anagram {

std::vector<std::string> anagram::matches(std::vector<std::string> words) {
    std::vector<std::string> matches{};

    if (words.empty()) {
        return matches;
    }

    for (auto word : words) {
        if (word.empty()) {
            continue;
        }

        std::string lower{};
        std::string sorted{};

        std::transform(word.begin(), word.end(), std::back_inserter(lower),
                       tolower);

        std::transform(word.begin(), word.end(), std::back_inserter(sorted),
                       tolower);
        std::sort(sorted.begin(), sorted.end());

        if (target_lower == lower) {
            continue;
        }

        if (target_sorted == sorted) {
            matches.emplace_back(word);
        }
    }

    return matches;
}

} // namespace anagram
