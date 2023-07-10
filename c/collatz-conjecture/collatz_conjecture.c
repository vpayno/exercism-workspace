#include "collatz_conjecture.h"

int steps(int start) {
    if (start < 1) {
        return ERROR_VALUE;
    }

    if (start == 1) {
        return 0;
    }

    int num = start;
    int count = 0;

    while (num > 1) {
        count += 1;

        if (num % 2 == 0) {
            num /= 2;
        } else {
            num = num * 3 + 1;
        }
    }

    return count;
}
