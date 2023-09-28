#include "prime_factors.h"

size_t find_factors(uint64_t number, uint64_t factors[static MAXFACTORS]) {
    size_t count = 0;

    switch (number) {
    case 0:
    case 1:
        return count;
    case 2:
        factors[count++] = 2;
        return count;
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
