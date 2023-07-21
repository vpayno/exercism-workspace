#if !defined(TRINARY_HPP)
#define TRINARY_HPP

#include <cmath>
#include <numeric>
#include <regex>
#include <string>

namespace trinary {

int to_decimal(std::string trinary);

bool is_valid_input(std::string trinary);

} // namespace trinary

#endif // TRINARY_HPP
