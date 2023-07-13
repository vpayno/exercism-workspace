#include "hamming.h"

int compute(const char *lhs, const char *rhs) {
    if (strlen(lhs) != strlen(rhs)) {
        return ERROR;
    }

    int distance = 0;

    while (*lhs != '\0' || *rhs != '\0') {
        if (toupper(*lhs) != toupper(*rhs)) {
            distance += 1;
        }

        lhs++;
        rhs++;
    }

    return distance;
}
