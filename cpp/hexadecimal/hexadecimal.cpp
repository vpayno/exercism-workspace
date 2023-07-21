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
    if (!is_valid_input(hexadecimal)) {
        return 0;
    }

    int exp{0};

    auto h2d_op = [exp](int sum, char rune) mutable -> int {
        const char digit = (char)std::tolower(rune);

        // we already know the input string is valid so we can keep it simple
        if ((bool)std::isdigit(digit)) {
            sum += (digit - '0') * (int)std::pow(16, exp++);
        } else {
            sum += (digit - 'W') * (int)std::pow(16, exp++);
        }

        return sum;
    };

    return std::accumulate(hexadecimal.rbegin(), hexadecimal.rend(), 0, h2d_op);
}

// input must only contain [0-9a-f]
bool is_valid_input(const std::string hexadecimal) {
    const std::regex re_hex_num("^[a-fA-F0-9]+$", std::regex_constants::egrep);

    return std::regex_search(hexadecimal, re_hex_num);
}

} // namespace hexadecimal
