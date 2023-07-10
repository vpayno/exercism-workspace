#include "anagram.h"

void find_anagrams(const char *subject, struct candidates *candidates) {
    if (!subject || !candidates) {
        return;
    }

    char sub_lc[MAX_STR_LEN] = {'\0'};
    char sub_lc_sorted[MAX_STR_LEN] = {'\0'};

    strcpy(sub_lc, subject);
    lowercase(sub_lc);

    strcpy(sub_lc_sorted, sub_lc);
    sort(sub_lc_sorted);

    for (size_t i = 0; i < candidates->count; i++) {
        candidates->candidate[i].is_anagram = NOT_ANAGRAM;

        char word_lc[MAX_STR_LEN] = {'\0'};

        strcpy(word_lc, candidates->candidate[i].word);
        lowercase(word_lc);

        if (strcmp(sub_lc, word_lc) == 0) {
            continue;
        }

        char word_lc_sorted[MAX_STR_LEN] = {'\0'};

        strcpy(word_lc_sorted, word_lc);
        sort(word_lc_sorted);

        if (strcmp(sub_lc_sorted, word_lc_sorted) == 0) {
            candidates->candidate[i].is_anagram = IS_ANAGRAM;
        }
    }
}

void lowercase(char str[]) {
    for (int i = 0; str[i]; i++) {
        str[i] = tolower(str[i]);
    }
}

void sort(char str[]) {
    int len = strlen(str);
    char temp;

    for (int i = 0; i < len - 1; i++) {
        for (int j = i + 1; j < len; j++) {
            if (str[i] > str[j]) {
                temp = str[i];
                str[i] = str[j];
                str[j] = temp;
            }
        }
    }
}
