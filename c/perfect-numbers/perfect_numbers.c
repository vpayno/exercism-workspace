#include "perfect_numbers.h"

kind classify_number(int64_t number) {
    kind result = ERROR;

    if (number <= 0) {
        return result;
    }

    factors_list_t numbers = factors(number);
    int64_t aliquotSum = sum(numbers);

    if (aliquotSum > number) {
        result = ABUNDANT_NUMBER;
    } else if (aliquotSum < number) {
        result = DEFICIENT_NUMBER;
    } else {
        result = PERFECT_NUMBER;
    }

    return result;
}

int64_t sum(const factors_list_t numbers) {
    int64_t total = 0;

    if (numbers.size <= 0) {
        return total;
    }

    for (size_t i = 0; i < numbers.size; i++) {
        total += numbers.factors[i];
    }

    return total;
}

factors_list_t factors(int64_t number) {
    factors_list_t numbers;
    numbers.size = 0;

    if (number <= 0) {
        return numbers;
    }

    for (int64_t factor = 1; factor < number; factor++) {
        if (number % factor == 0) {
            numbers.factors[numbers.size++] = factor;
        }
    }

    return numbers;
}
