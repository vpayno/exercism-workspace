#include "reverse_string.hpp"

namespace reverse_string {

std::string reverse_string(std::string text) {

    std::string reversed;

    if (text.empty()) {
        return reversed;
    }

    std::copy(text.rbegin(), text.rend(), std::back_inserter(reversed));

    return reversed;
}

} // namespace reverse_string
