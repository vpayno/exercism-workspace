#include "acronym.h"

#include <iostream>

namespace acronym {

std::string acronym(std::string text) {
    std::string result{};

    if (text.empty()) {
        return result;
    }

    bool first{true};
    for (auto rune : text) {
        if ((bool)isalpha(rune) && first) {
            result += (char)toupper(rune);
            first = false;

            continue;
        }

        if ((bool)isspace(rune) or rune == '-') {
            first = true;

            continue;
        }
    }

    return result;
}

} // namespace acronym
