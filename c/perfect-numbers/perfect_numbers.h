#ifndef PERFECT_NUMBERS_H
#define PERFECT_NUMBERS_H

#define STRUCT_BYTE_ALIGN (128)
#define MAX_FACTORS (256)

#include <stdint.h>
#include <stdlib.h>

typedef enum {
    PERFECT_NUMBER = 1,
    ABUNDANT_NUMBER = 2,
    DEFICIENT_NUMBER = 3,
    ERROR = -1
} kind;

typedef struct {
    size_t size;
    int64_t factors[MAX_FACTORS];
} factors_list_t;

int64_t sum(factors_list_t numbers);

factors_list_t factors(int64_t number);

kind classify_number(int64_t number);

#endif
