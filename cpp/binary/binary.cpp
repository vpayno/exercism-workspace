#include "binary.h"
#include <cmath>
#include <numeric>
#include <regex>
#include <string>

namespace binary {

// lol - I solved the hexadecimal exercism first then used it to solve trinary
// and this one.

/* To convert a binary number to a decimal manually,
 * you must start by multiplying the binary number by 2.
 *
 * Then, you raise it to a power of 0 and
 * increase that power by 1 each time according to the binary number
 * equivalent.
 *
 * We start from the right of the binary number and
 * go to the left when applying the powers.
 *
 * Each time you multiply a number by 2, the power of 2 increases.
 */

int convert(std::string binary) {
    if (!is_valid_input(binary)) {
        return 0;
    }

    int exp{0};

    auto b2d_op = [exp](int sum, char digit) mutable -> int {
        // we already know the input string is valid so we can keep it simple
        sum += (digit - '0') * (int)std::pow(2, exp++);

        return sum;
    };

    return std::accumulate(binary.rbegin(), binary.rend(), 0, b2d_op);
}

bool is_valid_input(std::string binary) {
    const std::regex re_binary_num("^[0-1]+$", std::regex_constants::egrep);
    return std::regex_search(binary, re_binary_num);
}

} // namespace binary
