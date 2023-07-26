#include "pangram.h"

#include <iostream>

namespace pangram {

bool is_pangram(std::string input) {
    const size_t letter_count = 26;

    if (letter_count > input.size()) {
        return false;
    }

    std::string text{};

    std::transform(input.begin(), input.end(), std::back_inserter(text),
                   tolower);

    std::map<char, bool> tracker{};

    for (auto rune : text) {
        if (!(bool)isalpha(rune)) {
            continue;
        }

        tracker[rune] = true;
    }

    const size_t count{tracker.size()};

    return letter_count == count;
}

} // namespace pangram
