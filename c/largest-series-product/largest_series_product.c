#include "largest_series_product.h"

int64_t largest_series_product(char *digits, size_t span) {
    if (!is_valid_input(digits, span)) {
        return ERROR;
    }

    size_t remaining = strlen(digits);
    int largest = 0;

    for (size_t i = 0; i < strlen(digits); i++) {
        if (remaining < span) {
            break;
        }

        remaining -= 1;

        int product = 1;

        for (size_t j = i; j < i + span; j++) {
            int num = digits[j] - '0';

            product *= num;
        }

        if (product > largest) {
            largest = product;
        }
    }

    return largest;
}

bool is_valid_input(char *digits, size_t span) {
    if (span > strlen(digits)) {
        return false;
    }

    if (strlen(digits) == 0) {
        return false;
    }

    if (span == 0) {
        return false;
    }

    for (size_t i = 0; i < strlen(digits); i++) {
        if (!isdigit(digits[i])) {
            return false;
        }
    }

    return true;
}
