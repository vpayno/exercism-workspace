#ifndef LUHN_H
#define LUHN_H

#include <ctype.h>
#include <stdbool.h>
#include <string.h>

#define MAX_SIZE (256)

typedef struct {
    int size;
    int list[MAX_SIZE];
} numbers_list_t;

bool luhn(const char *str);

int sum(numbers_list_t numbers);

int count_numbers(const char *str);

numbers_list_t get_numbers(const char *str);

bool is_valid_input(const char *str);

#endif
