#include "roman_numerals.h"

char *to_roman_numeral(unsigned int number) {
    char *ptr = calloc(16, sizeof(char));
    char *result = ptr;

    if (number == 0 || number >= 4000) {
        return result;
    }

    unsigned int decimals[] = {1000, 900, 500, 400, 100, 90, 50,
                               40,   10,  9,   5,   4,   1};
    unsigned int dec_len = sizeof(decimals) / sizeof(decimals[0]);

    for (unsigned int i = 0; i < dec_len; i++) {
        while (number >= decimals[i]) {
            char *roman = decimal_to_roman(decimals[i]);

            memcpy(ptr, roman, strlen(roman));
            ptr += strlen(roman);
            free(roman);

            number -= decimals[i];
        }
    }

    return result;
}

char *decimal_to_roman(unsigned int number) {

    char *ptr = calloc(16, sizeof(char));
    char *result = ptr;

    switch (number) {
    case 1000:
        memcpy(ptr, "M", strlen("M"));
        ptr += strlen("M");
        break;
    case 900:
        memcpy(ptr, "CM", strlen("CM"));
        ptr += strlen("CM");
        break;
    case 500:
        memcpy(ptr, "D", strlen("D"));
        ptr += strlen("D");
        break;
    case 400:
        memcpy(ptr, "CD", strlen("CD"));
        ptr += strlen("CD");
        break;
    case 100:
        memcpy(ptr, "C", strlen("C"));
        ptr += strlen("C");
        break;
    case 90:
        memcpy(ptr, "XC", strlen("XC"));
        ptr += strlen("XC");
        break;
    case 50:
        memcpy(ptr, "L", strlen("L"));
        ptr += strlen("L");
        break;
    case 40:
        memcpy(ptr, "XL", strlen("XL"));
        ptr += strlen("XL");
        break;
    case 10:
        memcpy(ptr, "X", strlen("X"));
        ptr += strlen("X");
        break;
    case 9:
        memcpy(ptr, "IX", strlen("IX"));
        ptr += strlen("IX");
        break;
    case 5:
        memcpy(ptr, "V", strlen("V"));
        ptr += strlen("V");
        break;
    case 4:
        memcpy(ptr, "IV", strlen("IV"));
        ptr += strlen("IV");
        break;
    case 1:
        memcpy(ptr, "I", strlen("I"));
        ptr += strlen("I");
        break;
    }

    return result;
}
