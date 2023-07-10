#ifndef ANAGRAM_H
#define ANAGRAM_H

#include <ctype.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STR_LEN 20

enum anagram_status { UNCHECKED = -1, NOT_ANAGRAM, IS_ANAGRAM };

struct candidate {
    enum anagram_status is_anagram;
    const char *word;
};

struct candidates {
    struct candidate *candidate;
    size_t count;
};

/**
 * @description - determines if any of the words in candidate are anagrams
 *                for subject. Contents of candidate structures may be modified.
 */
void find_anagrams(const char *subject, struct candidates *candidates);

/**
 * @description - converts the string to lowercase.
 *                Contents of the string may be modified.
 */
void lowercase(char str[]);

/**
 * @description - sorts the string's characters.
 *                Contents of the string may be modified.
 */
void sort(char str[]);

#endif
