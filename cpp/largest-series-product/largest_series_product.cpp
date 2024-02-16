#include "largest_series_product.hpp"
#include <cstddef>
#include <iterator>
#include <regex>
#include <stdexcept>
#include <string>

namespace largest_series_product {

int largest_product(std::string digits, int span) {
    if (!is_valid_input(digits, span)) {
        // never executed because we throw an exception
        return -1;
    }

    int largest{-1};
    size_t remaining = digits.length();

    auto current = digits.begin(); // input iterator

    for (const char rune : digits) {
        // keep track of the remaing "size" of our input
        if (remaining < (size_t)span) {
            break;
        }
        remaining -= 1;

        int product{1};
        int digit{rune - '0'}; // 1st element of the span
        auto next = current;   // span iterator

        product *= digit;

        // inner loops enters on the second element of the span
        for (int i = 1; i < span; i++) {
            std::advance(next, 1);
            digit = *next - '0';
            product *= digit;
        }

        if (product > largest) {
            largest = product;
        }

        std::advance(current, 1);
    }

    return largest;
}

bool is_valid_input(std::string digits, int span) {
    if (digits.empty()) {
        throw std::domain_error{"input is empty"};
    }

    if (span <= 0) {
        throw std::domain_error{"span is less than 1"};
    }

    if (digits.length() < size_t(span)) {
        throw std::domain_error{"span is longer than input"};
    }

    const std::regex re_num_only("^[0-9]+$", std::regex_constants::egrep);
    if (!std::regex_search(digits, re_num_only)) {
        throw std::domain_error{"intput needs to only consist of digits"};
    }

    return true;
}

} // namespace largest_series_product
