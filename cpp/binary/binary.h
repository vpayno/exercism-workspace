#if !defined(BINARY_H)
#define BINARY_H

#include <cmath>
#include <numeric>
#include <regex>
#include <string>

namespace binary {

int convert(std::string binary);
bool is_valid_input(std::string binary);

} // namespace binary

#endif // BINARY_H
