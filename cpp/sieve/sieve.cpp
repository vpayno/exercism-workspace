#include "sieve.hpp"

namespace sieve {

std::vector<int> primes(int limit) {
    std::vector<int> result{};
    std::vector<bool> numbers{};

    // odd looking fast-return block
    switch (limit) {
    case 0:
        [[fallthrough]];
    case 1:
        return result;
    case 2:
        result.push_back(2);
        return result;
    }

    numbers.resize(limit + 1, true);
    int index = 0;
    for (auto iter = numbers.begin(); iter < numbers.end(); iter++) {
        // if even -> (except for 2) can't be prime
        if (index % 2 == 0) {
            numbers.at(index) = false;
        }

        index += 1;
    }
    numbers.at(0) = numbers.at(1) = false;
    numbers.at(2) = true;

    for (int number = 3; number <= limit; number += 2) {
        // is prime
        if (numbers.at(number)) {
            for (int j = 3; number * j <= limit; j++) {
                const size_t index = size_t(number) * size_t(j);
                numbers.at(index) = false;
            }
        }
    }

    index = 0;
    for (auto iter = numbers.begin(); iter < numbers.end(); iter++) {
        // if prime
        if (*iter) {
            result.push_back(index);
        }

        index += 1;
    }

    return result;
}

} // namespace sieve
