#include "word_count.h"

int count_words(const char *sentence, word_count_word_t *words) {
    int word_count = 0;

    if (sentence == NULL || words == NULL) {
        return ERROR;
    }

    char word[MAX_WORD_LENGTH + 1];
    const char *letter_ptr = sentence;

    while (*letter_ptr != '\0') {
        // keep scanning until we hit a letter or number
        while (*letter_ptr != '\0' && !isalnum(*letter_ptr)) {
            letter_ptr++;
        }

        // start collecting the next word
        char *word_ptr = word;

        // save the current word (including an apostrophe)
        while (*letter_ptr != '\0' &&
               (*letter_ptr == '\'' || isalnum(*letter_ptr))) {
            *word_ptr++ = tolower(*letter_ptr++);
        }

        if (word_ptr == word) {
            break;
        }

        // strip apostrophe from word
        *word_ptr = '\0';
        while (word_ptr - 1 >= word && *(word_ptr - 1) == '\'') {
            *--word_ptr = '\0';
        }

        int word_index = 0;

        // find the position of the word in our list or get the last position
        for (word_index = 0; word_index < word_count; word_index++) {
            if (strcmp(word, words[word_index].text) == EQUAL) {
                break;
            }
        }

        if (strlen(words[word_index].text) == 0) {
            // add a new word to the word list
            strcpy(words[word_index].text, word);
            words[word_index].count = 1;
        } else {
            // increment the count of the last word found
            words[word_index].count += 1;
        }

        // keep track of the size of our word list
        if (word_index == word_count) {
            word_count += 1;
        }
    }

    return word_count;
}
