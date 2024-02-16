#include "prime_factors.hpp"
#include <vector>

namespace prime_factors {

// number should be unsigned
std::vector<int> of(int number) {
    std::vector<int> factors{};

    switch (number) {
    case 0:
        [[fallthrough]];
    case 1:
        return factors;
    case 2:
        factors.push_back(2);
        return factors;
    }

    int factor{0};

    factor = 2;
    while (number % factor == 0 and number > 1) {
        number /= factor;
        factors.push_back(factor);
    }

    factor = 3;
    while (number > 1) {
        while (number % factor == 0 and number > 1) {
            number /= factor;
            factors.push_back(factor);
        }

        factor += 2;
    }

    return factors;
}

} // namespace prime_factors
