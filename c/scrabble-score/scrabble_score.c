#include "scrabble_score.h"

unsigned int score(const char *word) {
    int result = 0;

    if (!word) {
        return result;
    }

    if ((int)strlen(word) == 0) {
        return result;
    }

    while (*word) {
        char letter = (char)tolower(*word++);

        switch (letter) {
        case 'd':
        case 'g':
            result += 2;
            break;
        case 'b':
        case 'c':
        case 'm':
        case 'p':
            result += 3;
            break;
        case 'f':
        case 'h':
        case 'v':
        case 'w':
        case 'y':
            result += 4;
            break;
        case 'k':
            result += 5;
            break;
        case 'j':
        case 'x':
            result += 8;
            break;
        case 'q':
        case 'z':
            result += 10;
            break;
        default:
            // A, E, I, O, U, L, N, R, S, T
            result += 1;
            break;
        }
    }

    return result;
}
