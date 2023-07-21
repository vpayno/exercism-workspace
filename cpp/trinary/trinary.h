#if !defined(TRINARY_H)
#define TRINARY_H

#include <cmath>
#include <numeric>
#include <regex>
#include <string>

namespace trinary {

int to_decimal(std::string trinary);

bool is_valid_input(std::string trinary);

} // namespace trinary

#endif // TRINARY_H
