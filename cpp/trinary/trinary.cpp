#include "trinary.hpp"
#include <cmath>
#include <numeric>
#include <regex>
#include <string>

namespace trinary {

// lol - I solved the hexadecimal exercism first then used it to solve this one.

/* To convert a trinary number to a decimal manually,
 * you must start by multiplying the trinary number by 3.
 *
 * Then, you raise it to a power of 0 and
 * increase that power by 1 each time according to the trinary number
 * equivalent.
 *
 * We start from the right of the trinary number and
 * go to the left when applying the powers.
 *
 * Each time you multiply a number by 3, the power of 3 increases.
 */
int to_decimal(const std::string trinary) {
    if (!is_valid_input(trinary)) {
        return 0;
    }

    int exp{0};

    auto t2d_op = [exp](int sum, char digit) mutable -> int {
        // we already know the input string is valid so we can keep it simple
        sum += (digit - '0') * (int)std::pow(3, exp++);

        return sum;
    };

    return std::accumulate(trinary.rbegin(), trinary.rend(), 0, t2d_op);
}

// input must only contain [0-2]
bool is_valid_input(const std::string trinary) {
    const std::regex re_tri_num("^[0-2]+$", std::regex_constants::egrep);

    return std::regex_search(trinary, re_tri_num);
}

} // namespace trinary
