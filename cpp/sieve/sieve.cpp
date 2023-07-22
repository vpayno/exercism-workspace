#include "sieve.hpp"

namespace sieve {

std::vector<int> primes(int limit) {
    std::vector<int> result{};
    std::vector<bool> numbers{};

    numbers.resize(limit + 1, true);
    int index = 0;
    for (auto iter = numbers.begin(); iter < numbers.end(); iter++) {
        // if even -> (except for 2) can't be prime
        if (index % 2 == 0) {
            numbers[index] = false;
        }

        index += 1;
    }
    numbers[0] = numbers[1] = false;
    numbers[2] = true;

    for (int number = 2; number <= limit; number++) {
        // is prime
        if (numbers[number]) {
            for (int i = 1, j = number * number; j <= limit;
                 i++, j = number * number + i * number) {
                numbers[j] = false;
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
