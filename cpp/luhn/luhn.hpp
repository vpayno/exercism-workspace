#if !defined(LUHN_HPP)
#define LUHN_HPP

#include <array>
#include <cctype>
#include <iterator>
#include <numeric>
#include <string>
#include <vector>

namespace luhn {

bool valid(std::string number);

bool is_valid_input(std::string sequence);

int sum(std::array<int, 256> numbers);

std::array<int, 256> get_numbers(std::string data);

} // namespace luhn

#endif // LUHN_HPP
