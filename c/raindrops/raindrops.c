#include "raindrops.h"

char *convert(char result[], int drops) {
    if (drops % PLING == 0) {
        strncat(result, sound_names[PLING], RESULT_SIZE);
    }

    if (drops % PLANG == 0) {
        strncat(result, sound_names[PLANG], RESULT_SIZE);
    }

    if (drops % PLONG == 0) {
        strncat(result, sound_names[PLONG], RESULT_SIZE);
    }

    if (!*result) {
        sprintf(result, "%d", drops);
    }

    return result;
}
