#if !defined(BINARY_HPP)
#define BINARY_HPP

#include <cmath>
#include <numeric>
#include <regex>
#include <string>

namespace binary {

int convert(std::string binary);
bool is_valid_input(std::string binary);

} // namespace binary

#endif // BINARY_HPP
