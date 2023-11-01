#ifndef ETL_H
#define ETL_H

#include <ctype.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int value;
    const char *keys;
} legacy_map; // input

typedef struct {
    char key;
    int value;
} new_map; // output

size_t convert(const legacy_map *input, size_t input_len, new_map **output);

int cmp(const void *value_a, const void *value_b);

#endif
