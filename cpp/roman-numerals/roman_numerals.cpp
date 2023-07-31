#include "roman_numerals.hpp"

namespace roman_numerals {

roman_number_t convert(decimal_t number) {
    roman_number_t roman_number{};

    if (number <= 0 or number >= 4000) {
        return roman_number;
    }

    for (auto iter = k_decimal_to_roman.rbegin();
         iter != k_decimal_to_roman.rend(); iter++) {
        while (number >= iter->first) {
            roman_number += iter->second;
            number -= iter->first;
        }
    }

    return roman_number;
}

} // namespace roman_numerals
