#include "isbn_verifier.h"

namespace isbn_verifier {

bool is_valid(isbn_number_t number) {
    bool result{false};

    if (number.empty()) {
        return result;
    }

    const std::string re_valid_str{R"--(^[0-9][0-9-]+[0-9X]$)--"};
    const std::regex re_valid_exp(re_valid_str, std::regex_constants::egrep);
    if (!std::regex_search(number, re_valid_exp)) {
        return result;
    }

    const std::string re_digits_str{R"--([0-9]|X)--"};
    const std::regex re_digits_exp(re_digits_str, std::regex_constants::egrep);

    auto digits_begin =
        std::sregex_iterator(number.begin(), number.end(), re_digits_exp);
    auto digits_end = std::sregex_iterator();

    int sum{0};
    int pos{10};

    auto digit_count = std::distance(digits_begin, digits_end);

    if (digit_count != 10) {
        return result;
    }

    for (auto iter = digits_begin; iter != digits_end; iter++) {
        auto re_match = *iter;
        const std::string digit_str = re_match[0];
        const char digit_char = digit_str[0];
        int digit{};

        if (digit_char == 'X') {
            digit = 10;
        } else {
            digit = digit_char - '0';
        }

        sum += digit * pos;

        pos -= 1;
    }

    result = sum % 11 == 0;

    return result;
}

} // namespace isbn_verifier
