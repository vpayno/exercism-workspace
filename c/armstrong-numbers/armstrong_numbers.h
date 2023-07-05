#ifndef ARMSTRONG_NUMBERS_H
#define ARMSTRONG_NUMBERS_H

#include <math.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define arr_len(x) (sizeof(x) / sizeof((x)[0]))

bool is_armstrong_number(int candidate);

#endif
