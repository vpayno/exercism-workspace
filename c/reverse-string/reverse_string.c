#include "reverse_string.h"
#include <stdlib.h>
#include <string.h>

char *reverse(const char *value) {
    unsigned long size = strlen(value); // does not include null

    char *reversed = malloc(size + 1);

    // since unsigned longs can't be negative, convert to long long
    for (long long i = (long long)size - 1, j = 0LL; i >= 0LL; i--, j++) {
        reversed[j] = value[i];
    }

    // make it a null-terminated string
    reversed[size] = '\0';

    return reversed;
}
