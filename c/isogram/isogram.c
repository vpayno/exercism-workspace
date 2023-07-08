#include "isogram.h"

bool is_isogram(const char phrase[]) {
    if (!phrase) {
        return false;
    }

    int phrase_length = (int)strlen(phrase);

    if (phrase_length <= 1) {
        return true;
    }

    for (int i = 0; i < (phrase_length - 1); i++) {

        char letter = (char)tolower(phrase[i]);

        if (!isalpha(letter)) {
            continue;
        }

        for (int j = i + 1; j < phrase_length; j++) {
            char inspect = (char)tolower(phrase[j]);

            if (!isalpha(inspect)) {
                continue;
            }

            if (letter == inspect) {
                return false;
            }
        }
    }

    return true;
}
