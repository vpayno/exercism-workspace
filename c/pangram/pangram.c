#include "pangram.h"

// regex.h doesn't have a way of replacing text in a string
// going to be inefficient and create a new string by walking it.

bool is_pangram(const char *sentence) {
    // is it null? not a pangram
    if (!sentence) {
        return false;
    }

    // empty string? not a pangram
    if ((int)strlen(sentence) == 0) {
        return false;
    }

    char *new_sentence = calloc(strlen(sentence) + 2, sizeof(char));

    // make a new string with just lowercase letters in it
    for (int i = 0, j = 0; i < (int)strlen(sentence); i++) {
        if (isalpha(sentence[i])) {
            new_sentence[j++] = tolower(sentence[i]);
        }
    }

    // less than 26 letters? not a pangram
    if (strlen(new_sentence) < ALPHABET_SIZE) {
        free(new_sentence);
        return false;
    }

    // make an array and map the indices to letters and the value to the count
    // a=>97, z=>122: subtract 97 from all character indices
    int counts[ALPHABET_SIZE] = {0};
    for (int i = 0; i < (int)strlen(new_sentence); i++) {
        int offset = (int)new_sentence[i] - CHAR_INT_OFFSET;
        counts[offset]++;
    }

    // are any of the counts 0?
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        if (counts[i] < 1) {
            free(new_sentence);
            return false;
        }
    }

    free(new_sentence);
    return true;
}
