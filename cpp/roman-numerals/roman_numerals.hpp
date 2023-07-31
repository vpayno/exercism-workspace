#if !defined(ROMAN_NUMERALS_HPP)
#define ROMAN_NUMERALS_HPP

#include <map>
#include <string>

namespace roman_numerals {

using roman_number_t = std::string;
using decimal_t = int;
using decimal_to_roman_t = std::map<decimal_t, roman_number_t>;

const decimal_to_roman_t k_decimal_to_roman = {
    std::make_pair(1, "I"),     std::make_pair(4, "IV"),
    std::make_pair(5, "V"),     std::make_pair(9, "IX"),
    std::make_pair(10, "X"),    std::make_pair(40, "XL"),
    std::make_pair(50, "L"),    std::make_pair(90, "XC"),
    std::make_pair(100, "C"),   std::make_pair(400, "CD"),
    std::make_pair(500, "D"),   std::make_pair(900, "CM"),
    std::make_pair(1'000, "M"),
};

roman_number_t convert(decimal_t number);

} // namespace roman_numerals

#endif // ROMAN_NUMERALS_HPP
