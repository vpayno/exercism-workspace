#include "isogram.hpp"

namespace isogram {

bool is_isogram(std::string input) {
    if (input.empty()) {
        return true;
    }

    bool result{true};

    std::string text{};

    std::transform(input.begin(), input.end(), std::back_inserter(text),
                   tolower);

    std::map<char, bool> tracker{};

    for (auto rune : text) {
        if (!(bool)isalpha(rune)) {
            continue;
        }

        // if found
        if (tracker.find(rune) != tracker.end()) {
            result = false;
            break;
        }

        tracker[rune] = true;
    }

    return result;
}

} // namespace isogram
