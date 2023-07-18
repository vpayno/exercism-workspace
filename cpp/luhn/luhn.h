#if !defined(LUHN_H)
#define LUHN_H

#include <array>
#include <string>

namespace luhn {

bool valid(std::string number);

bool is_valid_input(std::string sequence);

// not sure why it's complaining that sum is a global variable that needs to be
// a constant changing the name doesn't help. Is it because this is a C header
// file instead of a CPP header file? that does upset clang tools.
// NOLINTNEXTLINE(cppcoreguidelines-avoid-non-const-global-variables)
int sum(std::array<int, 256> numbers);

std::array<int, 256> get_numbers(std::string data);

} // namespace luhn

#endif // LUHN_H
