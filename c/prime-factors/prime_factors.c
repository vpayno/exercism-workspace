#include "prime_factors.h"

size_t find_factors(uint64_t number, uint64_t factors[static MAXFACTORS]) {
    size_t count = 0;

    switch (number) {
    case 0:
    case 1:
        return (size_t)0;
    case 2:
        factors[0] = 2;
        return (size_t)1;
    }

    int factor = 0;

    factor = 2;
    while (number % factor == 0 && number > 1) {
        number /= factor;
        factors[count++] = factor;
    }

    factor = 3;
    while (number > 1) {
        while (number % factor == 0 && number > 1) {
            number /= factor;
            factors[count++] = factor;
        }

        factor += 2;
    }

    return count;
}
