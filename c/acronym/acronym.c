#include "acronym.h"

char *abbreviate(const char *phrase) {
    if (phrase == NULL || *phrase == 0) {
        return NULL;
    }

    char *acronym = calloc(strlen(phrase), sizeof(char));

    bool next_is_initial = true;

    for (size_t i = 0; i < strlen(phrase); i++) {
        char candidate = (char)toupper(phrase[i]);

        if (candidate == '\'') {
            continue;
        }

        if (isalpha(candidate) && next_is_initial) {
            strncat(acronym, &candidate, sizeof(char));
            next_is_initial = false;
        } else if (!isalpha(candidate)) {
            next_is_initial = true;
        }
    }

    return acronym;
}
