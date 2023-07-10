#include "perfect_numbers.h"

kind classify_number(int64_t number) {
    kind result = ERROR;

    if (number <= 0) {
        return result;
    }

    int64_t *numbers = factors(number);
    int64_t aliquotSum = sum(numbers);

    // need to release memory allocated in factors()
    // should have allocated in classify()
    free(numbers);

    if (aliquotSum > number) {
        result = ABUNDANT_NUMBER;
    } else if (aliquotSum < number) {
        result = DEFICIENT_NUMBER;
    } else {
        result = PERFECT_NUMBER;
    }

    return result;
}

int64_t sum(const int64_t *numbers) {
    int64_t total = 0;
    size_t size = MAX_FACTORS;

    for (size_t i = 0; i < size; i++) {
        total += numbers[i];
    }

    return total;
}

int64_t *factors(int64_t number) {
    int64_t *numbers = (int64_t *)calloc(MAX_FACTORS, sizeof(int64_t));
    size_t count = 0;

    if (number <= 0) {
        return numbers;
    }

    for (int64_t factor = 1; factor < number; factor++) {
        if (number % factor == 0) {
            numbers[count++] = factor;
        }
    }

    return numbers;
}
