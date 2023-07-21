#if !defined(HEXADECIMAL_H)
#define HEXADECIMAL_H

#include <cmath>
#include <regex>
#include <string>

namespace hexadecimal {

int convert(std::string hexadecimal);

bool is_valid_input(std::string hexadecimal);

} // namespace hexadecimal

#endif // HEXADECIMAL_H
