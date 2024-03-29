#include "luhn.hpp"
#include <cctype>
#include <iterator>
#include <numeric>
#include <string>
#include <vector>

namespace luhn {

bool valid(const std::string number) {
    bool result = false;

    // fail fast if the string isn't a valid (only numbers and spaces)
    if (!is_valid_input(number)) {
        return result;
    }

    // extract the numbers from the string in reverse order
    std::vector<int> numbers = get_numbers(number);

    // double numbers with index 1, 3, 5, ...
    for (auto it = std::next(numbers.begin()); it != numbers.end();
         std::advance(it, 2)) {
        // make sure it+=2 hasn't moved us past the end of the vector
        if (it >= numbers.end()) {
            break;
        }

        // double the number
        *it *= 2;

        // if the doubled number is > 9, subtract 9 from it
        if (*it > 9) {
            *it -= 9;
        }
    }

    // if the sum is divisible by 10, it's valid
    const int num_sum = sum(numbers);
    if (num_sum % 10 == 0) {
        result = true;
    }

    return result;
}

// does the string only have digits and spaces in it?
bool is_valid_input(const std::string sequence) {
    if (sequence.size() <= 1) {
        return false;
    }

    int digit_count = 0;

    for (const char rune : sequence) {
        if (std::isdigit(rune) > 0) {
            digit_count += 1;
        }

        if (std::isdigit(rune) == 0 and std::isspace(rune) == 0) {
            return false;
        }
    }

    return digit_count >= 2;
}

// sums numbers in an vector
int sum(const std::vector<int> numbers) {
    const int sum = std::accumulate(numbers.begin(), numbers.end(), 0);

    return sum;
}

// extract the numbers from the string in reverse order
std::vector<int> get_numbers(const std::string data) {
    std::vector<int> numbers = {};

    for (auto src_it = data.crbegin(); src_it != data.crend(); src_it++) {
        if (std::isdigit(*src_it) > 0) {
            numbers.emplace_back(*src_it - '0');
        }
    }

    return numbers;
}

} // namespace luhn
