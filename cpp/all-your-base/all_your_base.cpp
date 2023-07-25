#include "all_your_base.h"

namespace all_your_base {

std::vector<unsigned int>
convert(const unsigned int input_base,
        const std::vector<unsigned int> input_sequence,
        const unsigned int output_base) {
    if (input_base <= 1) {
        throw std::invalid_argument{
            "input base must be greaterthan or equal to 2"};
    }

    if (output_base <= 1) {
        throw std::invalid_argument{
            "output base must be greaterthan or equal to 2"};
    }

    if (input_sequence.empty()) {
        return std::vector<unsigned int>{};
    }

    if (*std::max_element(input_sequence.begin(), input_sequence.end()) >=
        input_base) {
        throw std::invalid_argument{
            "invalid input sequence for given input base"};
    }

    auto base2ten_op = [input_base](unsigned int base_ten, unsigned int digit) {
        base_ten *= input_base;
        base_ten += digit;

        return base_ten;
    };

    unsigned int base_ten{std::accumulate(
        input_sequence.begin(), input_sequence.end(), 0U, base2ten_op)};

    std::vector<unsigned int> output_sequence{};

    while (base_ten > 0) {
        output_sequence.push_back(base_ten % output_base);

        base_ten /= output_base;
    }

    std::reverse(output_sequence.begin(), output_sequence.end());

    return output_sequence;
}

} // namespace all_your_base
