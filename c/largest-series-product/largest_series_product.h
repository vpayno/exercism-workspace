#ifndef LARGEST_SERIES_PRODUCT_H
#define LARGEST_SERIES_PRODUCT_H

#include <ctype.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#define ERROR (-1)

int64_t largest_series_product(char *digits, size_t span);

bool is_valid_input(char *digits, size_t span);

#endif
