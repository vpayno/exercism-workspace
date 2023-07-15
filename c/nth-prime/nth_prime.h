#ifndef NTH_PRIME_H
#define NTH_PRIME_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define LIMIT (1000000)
#define MAX_PRIMES (100000)

uint32_t nth(uint32_t nth_prime);

uint32_t sieve(uint32_t limit, size_t max_primes, size_t nth_prime);

#endif
