#ifndef PERFECT_NUMBERS_H
#define PERFECT_NUMBERS_H

#define MAX_FACTORS (256)

#include <stdint.h>
#include <stdlib.h>

typedef enum {
    PERFECT_NUMBER = 1,
    ABUNDANT_NUMBER = 2,
    DEFICIENT_NUMBER = 3,
    ERROR = -1
} kind;

int64_t sum(const int64_t numbers[]);

int64_t *factors(int64_t number);

kind classify_number(int64_t number);

#endif
