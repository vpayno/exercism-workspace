#include "perfect_numbers.hpp"

namespace perfect_numbers {

kind classify(int number) {
    if (number <= 0) {
        throw std::domain_error{"perfect numbers are positive"};
    }

    std::vector<int> factors{};

    for (int factor{1}; factor < number; factor++) {
        if ((number % factor) == 0) {
            factors.emplace_back(factor);
        }
    }

    int aliquotSum{0};

    auto sum_op = [](int sum, int num) { return sum + num; };

    aliquotSum =
        std::accumulate(factors.begin(), factors.end(), aliquotSum, sum_op);

    kind result{perfect};

    if (aliquotSum > number) {
        result = abundant;
    } else if (aliquotSum < number) {
        result = deficient;
    }

    return result;
}

} // namespace perfect_numbers
