#include "sieve.h"

uint32_t sieve(uint32_t limit, uint32_t *primes, size_t max_primes) {
    uint32_t prime_counter = 0;

    if (limit < 2 || max_primes == 0) {
        return prime_counter;
    }

    // bool *is_prime = calloc(limit+1, sizeof(bool));
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

    return prime_counter;
}
