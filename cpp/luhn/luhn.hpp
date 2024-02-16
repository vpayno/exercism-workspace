#if !defined(LUHN_HPP)
#define LUHN_HPP

#include <string>
#include <vector>

namespace luhn {

bool valid(std::string number);

bool is_valid_input(std::string sequence);

int sum(std::vector<int> numbers);

std::vector<int> get_numbers(std::string data);

} // namespace luhn

#endif // LUHN_HPP
