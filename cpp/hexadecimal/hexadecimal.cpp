#include "hexadecimal.h"

namespace hexadecimal {

/* To convert a hexadecimal to a decimal manually,
 * you must start by multiplying the hex number by 16.
 *
 * Then, you raise it to a power of 0 and
 * increase that power by 1 each time according to the hexadecimal number
 * equivalent.
 *
 * We start from the right of the hexadecimal number and
 * go to the left when applying the powers.
 *
 * Each time you multiply a number by 16, the power of 16 increases.
 */
int convert(const std::string hexadecimal) {
    int decimal{0};

    if (!is_valid_input(hexadecimal)) {
        return decimal;
    }

    std::string rev_hex;

    rev_hex.assign(hexadecimal.rbegin(), hexadecimal.rend());

    int exp{0};

    for (const char rune : rev_hex) {
        const char digit = (char)std::tolower(rune);

        if ((bool)std::isdigit(digit)) {
            decimal += (digit - '0') * (int)std::pow(16, exp++);
        } else {
            decimal += (digit - 'W') * (int)std::pow(16, exp++);
        }
    }

    return decimal;
}

// input must only contain [0-9a-f]
bool is_valid_input(const std::string hexadecimal) {
    const std::regex re_hex_num("^[a-fA-F0-9]+$", std::regex_constants::egrep);

    return std::regex_search(hexadecimal, re_hex_num);
}

} // namespace hexadecimal
