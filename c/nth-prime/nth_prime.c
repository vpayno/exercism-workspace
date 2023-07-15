#include "nth_prime.h"

uint32_t nth(uint32_t nth_prime) { return sieve(LIMIT, MAX_PRIMES, nth_prime); }

uint32_t sieve(uint32_t limit, size_t max_primes, size_t nth_prime) {
    uint32_t prime = 0;
    uint32_t prime_counter = 0;

    if (nth_prime <= 0) {
        return 0;
    }

    if (nth_prime <= 2) {
        return nth_prime + 1;
    }

    if (limit < 2 || max_primes == 0) {
        return prime_counter;
    }

    uint32_t *primes = calloc(LIMIT, sizeof(uint32_t));

    bool is_prime[limit + 1];
    memset(is_prime, true, sizeof(is_prime));

    for (uint32_t i = 2; i <= limit; i++) {
        if (is_prime[i]) {
            primes[prime_counter++] = i;

            if (prime_counter >= max_primes) {
                break;
            }

            for (uint32_t j = 2; i * j <= limit; j++) {
                is_prime[i * j] = false;
            }
        }
    }

    size_t count = 0;
    for (uint32_t i = 2; i <= limit; i++) {
        if (is_prime[i]) {
            count += 1;
        }

        if (count == nth_prime) {
            prime = i;
            break;
        }
    }

    free(primes);

    return prime;
}
