#include "etl.hpp"
#include <cctype>

namespace etl {

new_format_t transform(const old_format_t old_format) {
    new_format_t new_format{};

    for (auto const &[score, letters] : old_format) {
        for (auto letter : letters) {
            auto key = (letter_t)tolower(letter);
            new_format[key] = score;
        }
    }

    return new_format;
}

} // namespace etl
