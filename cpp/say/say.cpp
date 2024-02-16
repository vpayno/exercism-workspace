#include "say.hpp"
#include <cstdint>
#include <stdexcept>
#include <string>
#include <utility>

namespace say {

void check_runtime_error(bool condition, message_t message) {
    if (condition) {
        throw std::domain_error{message};
    }
}

std::string in_english(int128_t number) {
    check_runtime_error(number < 0, "input number is negative");
    check_runtime_error(number >= k_trillion, "input number is negative");

    // to make life a little easier
    uint64_t pos_num{number};

    std::string spoken{};

    const parts_t parts = {
        std::make_pair(0ULL, "zero"),
        std::make_pair(1ULL, "one"),
        std::make_pair(2ULL, "two"),
        std::make_pair(3ULL, "three"),
        std::make_pair(4ULL, "four"),
        std::make_pair(5ULL, "five"),
        std::make_pair(6ULL, "six"),
        std::make_pair(7ULL, "seven"),
        std::make_pair(8ULL, "eight"),
        std::make_pair(9ULL, "nine"),
        std::make_pair(10ULL, "ten"),
        std::make_pair(11ULL, "eleven"),    // corner case
        std::make_pair(12ULL, "twelve"),    // corner case
        std::make_pair(13ULL, "thirteen"),  // corner case
        std::make_pair(14ULL, "fourteen"),  // four+teen
        std::make_pair(15ULL, "fifteen"),   // corner case
        std::make_pair(16ULL, "sixteen"),   // nine+teen
        std::make_pair(17ULL, "seventeen"), // nine+teen
        std::make_pair(18ULL, "eighteen"),  // corner case
        std::make_pair(19ULL, "nineteen"),  // nine+teen
        std::make_pair(20ULL, "twenty"),    // corner case
        std::make_pair(30ULL, "thirty"),    // corner case
        std::make_pair(40ULL, "forty"),     // four+ty
        std::make_pair(50ULL, "fifty"),     // corner case
        std::make_pair(60ULL, "sixty"),     // six+ty
        std::make_pair(70ULL, "seventy"),   // seven+ty
        std::make_pair(80ULL, "eighty"),    // eight+ty
        std::make_pair(90ULL, "ninety"),    // nine+ty
        std::make_pair(k_hundred, "hundred"),
        std::make_pair(k_thousand, "thousand"),
        std::make_pair(k_million, "million"),
        std::make_pair(k_billion, "billion"),
        std::make_pair(k_trillion, "tillion"),
    };

    // by handling this case now, we can use 0 as a special value
    if (pos_num == 0) {
        return parts.at(pos_num);
    }

    spoken += say_rest(pos_num, parts);
    spoken += say_hundreds(pos_num, parts);
    spoken += say_tens(pos_num, parts);

    return spoken;
}

std::string say_tens(uint64_t number, parts_t parts) {
    if (number == 0) {
        return "";
    }

    if (number <= 20ULL) {
        std::string part{parts.at(number)};

        return part;
    }

    if (number > 99ULL) {
        return "";
    }

    const uint64_t tens{number / 10 * 10};
    const uint64_t ones{number % 10};

    const std::string part1{parts.at(tens)};
    const std::string part2{parts.at(ones)};

    const std::string spoken{part1 + "-" + part2};

    return spoken;
}

std::string say_hundreds(uint64_t &number, parts_t parts) {
    if (number >= k_hundred and number < k_thousand) {
        const uint64_t quantity{number / 100};
        const uint64_t label{100};

        const std::string part1{parts.at(quantity)};
        const std::string part2{parts.at(label)};

        std::string spoken{part1 + " " + part2};

        number %= 100;

        if (number > 0) {
            spoken += " ";
        }

        return spoken;
    }

    return "";
}

std::string say_rest(uint64_t &number, parts_t parts) {
    uint64_t step{};

    if (number >= k_billion) {
        step = k_billion;
    } else if (number >= k_million) {
        step = k_million;
    } else if (number >= k_thousand) {
        step = k_thousand;
    } else if (number >= k_hundred) {
        step = k_hundred;
    }

    std::string spoken{};

    while (number >= k_thousand and step > 0) {
        uint64_t quantity{number / step};
        spoken += say_hundreds(quantity, parts);
        spoken += say_tens(quantity, parts);

        const uint64_t label{step};
        const std::string part{parts.at(label)};

        spoken += " " + part;

        number %= step;

        if (number > 0) {
            spoken += " ";
        }

        step /= k_thousand;
    }

    return spoken;
}

} // namespace say
