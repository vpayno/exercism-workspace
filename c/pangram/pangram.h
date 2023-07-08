#ifndef PANGRAM_H
#define PANGRAM_H

#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26
#define CHAR_INT_OFFSET 97

bool is_pangram(const char *sentence);

#endif
