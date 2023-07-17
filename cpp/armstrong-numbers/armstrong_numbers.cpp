#include "armstrong_numbers.hpp"

namespace armstrong_numbers {

bool is_armstrong_number(int candidate) {
    if (candidate < 10) {
        return true;
    }

    const int digit_count = (int)std::log10(candidate) + 1;
    int num = candidate;
    int pow_total = 0;

    while (num > 0) {
        const int pow_temp = num % 10;
        int pow_temp_total = 1;

        for (int i = 0; i < digit_count; i++) {
            pow_temp_total *= pow_temp;
        }
        pow_total += pow_temp_total;
        num /= 10;
    }

    return pow_total == candidate;
}

} // namespace armstrong_numbers
