#include "etl.h"

size_t convert(const legacy_map *input, const size_t input_len,
               new_map **output) {
    size_t size = 0;

    for (size_t i = 0; i < input_len; i++) {
        size += strlen(input[i].keys);
    }

    *output = calloc(size, sizeof(new_map));

    size_t key = 0;
    for (size_t i = 0; i < input_len; i++) {
        for (size_t j = 0; j < strlen(input[i].keys); j++) {
            (*output)[key].key = tolower(input[i].keys[j]);
            (*output)[key].value = tolower(input[i].value);

            key += 1;
        }
    }

    qsort(*output, size, sizeof(new_map), cmp);

    return size;
}

int cmp(const void *value_a, const void *value_b) {
    return ((new_map *)value_a)->key - ((new_map *)value_b)->key;
}
