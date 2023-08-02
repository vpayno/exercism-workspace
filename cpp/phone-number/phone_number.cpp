#include "phone_number.hpp"

#include <iostream>

namespace phone_number {

phone_number::phone_number(phone_number_t old_number) {
    std::cout << std::endl;
    std::cout << "vvv=========================================================="
                 "=====================vvv"
              << std::endl;

    // check to see if the number is valid and store it
    if (is_phone_number_valid(old_number)) {
        phone_number_t digits_only{};

        auto only_digits_op = [](char rune) { return (bool)isdigit(rune); };

        std::cout << "dirty: [" << old_number << "]" << std::endl;
        std::copy_if(old_number.begin(), old_number.end(),
                     std::back_inserter(digits_only), only_digits_op);
        std::cout << "cleaned: [" << digits_only << "]" << std::endl;

        if (digits_only.size() == 11) {
            _number = digits_only.substr(1);
        } else {
            _number = digits_only;
        }

        std::cout << "storing: [" << _number << "]" << std::endl;
    }
}

phone_number_t phone_number::number() const {
    std::cout << "_number: [" << _number << "]" << std::endl;

    return _number;
}

subscriber_number_t phone_number::subscriber_number() const {
    std::cout << "subscriber: [" << _number.substr(6) << "]" << std::endl;

    return _number.substr(6);
}

exchange_code_t phone_number::exchange_code() const {
    std::cout << "exchange: [" << _number.substr(3, 3) << "]" << std::endl;

    return _number.substr(3, 3);
}

area_code_t phone_number::area_code() const {
    std::cout << "area code: [" << _number.substr(0, 3) << "]" << std::endl;

    return _number.substr(0, 3);
}

phone_number::operator std::string() const {
    // NOLINTNEXTLINE(readability-identifier-length)
    std::stringstream ss;

    ss << "(" << area_code() << ") " << exchange_code() << '-'
       << subscriber_number();

    return ss.str();
}

bool phone_number::is_phone_number_valid(phone_number_t number) {
    const std::string re_str_0001{R"--([0-9])--"};
    const std::regex re_exp_0001(re_str_0001, std::regex_constants::egrep);

    auto digits_begin =
        std::sregex_iterator(number.begin(), number.end(), re_exp_0001);
    auto digits_end = std::sregex_iterator();
    auto digit_count = std::distance(digits_begin, digits_end);

    std::cout << "validate number: [" << number << "]" << std::endl;
    std::cout << "validate: digit_count: " << digit_count << std::endl;

    if (digit_count < 10) {
        throw std::domain_error{k_error_0001};
    }

    // more than 11 digits
    if (digit_count > 11) {
        throw std::domain_error{k_error_0003};
    }

    // letters not permitted
    const std::string re_str_0004{R"--([a-zA-Z])--"};
    const std::regex re_exp_0004(re_str_0004, std::regex_constants::egrep);

    auto letters_begin =
        std::sregex_iterator(number.begin(), number.end(), re_exp_0004);
    auto letters_end = std::sregex_iterator();
    auto letters_count = std::distance(letters_begin, letters_end);

    std::cout << "validate: letters_count: " << letters_count << std::endl;

    if (letters_count > 0) {
        // doesn't test for this??? love the inconsistency between language
        // tracks
        throw std::domain_error{k_error_0004};
    }

    // punctuations not permitted
    const std::string re_str_0005{R"--([\]\[\|:;><,?/\\"'!@#$%&*^])--"};
    const std::regex re_exp_0005(re_str_0005, std::regex_constants::egrep);

    auto punct_begin =
        std::sregex_iterator(number.begin(), number.end(), re_exp_0005);
    auto punct_end = std::sregex_iterator();
    auto punct_count = std::distance(punct_begin, punct_end);

    std::cout << "validate: punct_count: " << punct_count << std::endl;

    if (punct_count > 0) {
        // doesn't test for this? love the inconsistency between language tracks
        throw std::domain_error{k_error_0005};
    }

    // clean up number
    phone_number_t digits_eleven{};
    phone_number_t digits_ten{};

    auto only_digits_op = [](char rune) { return (bool)isdigit(rune); };

    std::copy_if(number.begin(), number.end(),
                 std::back_inserter(digits_eleven), only_digits_op);

    if (digits_eleven.size() == 10) {
        digits_eleven = "1" + digits_eleven;
    }

    std::cout << "eleven digits: " << digits_eleven << std::endl;

    std::cout << "converting from 11 to 10 digits: [" << digits_eleven << "] ";
    digits_ten = digits_eleven.substr(1);
    std::cout << "[" << digits_ten << "]" << std::endl;

    std::cout << "ten digits: " << digits_ten << std::endl;

    // 11 digits must start with 1
    if (digits_eleven[0] != '1') {
        throw std::domain_error{k_error_0002};
    }

    // area code cannot start with zero
    std::cout << "area code starts with 0? (" << digits_ten.substr(0, 1)
              << ") ";

    if (digits_ten.substr(0, 1)[0] == '0') {
        std::cout << "yes" << std::endl;

        throw std::domain_error{k_error_0006};
    }

    std::cout << "no" << std::endl;

    // area code cannot start with one
    std::cout << "area code starts with 1? (" << digits_ten.substr(0, 1)
              << ") ";

    if (digits_ten.substr(0, 1)[0] == '1') {
        std::cout << "yes" << std::endl;

        throw std::domain_error{k_error_0007};
    }

    std::cout << "no" << std::endl;

    // exchange code cannot start with zero
    std::cout << "exchange code starts with 0? (" << digits_ten.substr(3, 1)
              << ") ";

    if (digits_ten.substr(3, 1)[0] == '0') {
        std::cout << "yes" << std::endl;

        throw std::domain_error{k_error_0008};
    }

    std::cout << "no" << std::endl;

    // exchange code cannot start with one
    std::cout << "exchange code starts with 1? (" << digits_ten.substr(3, 1)
              << ") ";

    if (digits_ten.substr(3, 1)[0] == '1') {
        std::cout << "yes" << std::endl;

        throw std::domain_error{k_error_0009};
    }

    std::cout << "no" << std::endl;

    return true;
}

} // namespace phone_number
