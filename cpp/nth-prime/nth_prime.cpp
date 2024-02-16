#include "nth_prime.hpp"
#include <cstddef>
#include <stdexcept>
#include <vector>

namespace nth_prime {

int nth(int loc) {
    if (loc == 0) {
        throw std::domain_error("ERROR: nth prime numbers start at 1");
    }

    if (loc == 1) {
        return 2;
    }

    if (loc == 2) {
        return 3;
    }

    const int k_max_primes = 1'000'000;

    std::vector<int> primes = sieve::primes(k_max_primes);

    // .at() throws an out_of_range exception
    return primes.at(loc - 1);
}
} // namespace nth_prime

// CMakeLists.txt doesn't pull in other cpp or hpp files so just appending it
// here.
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
        return std::vector<int>{2};
    case 3:
        return std::vector<int>{2, 3};
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

    for (int number = 2; number <= limit; number++) {
        // is prime
        if (numbers.at(number)) {
            for (int j = 2; number * j <= limit; j++) {
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
