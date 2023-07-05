#include "armstrong_numbers.h"

bool is_armstrong_number(int candidate) {
    if (candidate < 10) {
        return true;
    }

    size_t size_of_char_array =
        (size_t)((ceil(log10(candidate)) + 1) * sizeof(char));
    char str[size_of_char_array];

    (void)sprintf(str, "%d", candidate);

    int sum = 0;
    int str_len = (int)strlen(str);

    for (int i = 0; i < str_len; i++) {
        char letter = str[i];
        int digit = letter - '0';

        sum += (int)pow(digit, str_len);
    }

    return sum == candidate;
}
