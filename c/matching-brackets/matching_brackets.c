#include "matching_brackets.h"

bool is_paired(const char *input) {
    char brackets[100] = {0};
    usize_t counter = 0;

    char *input_ptr = (char *)input;

    while (*input_ptr != '\0') {
        if (!bracket_either(*input_ptr)) {
            input_ptr++;
            continue;
        }

        if (bracket_open(*input_ptr)) {
            brackets[counter++] = *input_ptr;

            input_ptr++;
            continue;
        }

        if (bracket_close(*input_ptr)) {
            if (counter == 0) {
                return false;
            }

            if (!bracket_match(brackets[counter - 1], *input_ptr)) {
                return false;
            }

            counter--;
        }

        input_ptr++;
    }

    return counter == 0 ? true : false;
}

bool bracket_match(char open_bracket, char close_bracket) {
    if (open_bracket == '[' && close_bracket == ']') {
        return true;
    }

    if (open_bracket == '(' && close_bracket == ')') {
        return true;
    }

    if (open_bracket == '{' && close_bracket == '}') {
        return true;
    }

    return false;
}

bool bracket_open(char bracket) {
    return bracket == '[' || bracket == '(' || bracket == '{';
}

bool bracket_close(char bracket) {
    return bracket == ']' || bracket == ')' || bracket == '}';
}

bool bracket_either(char bracket) {
    return bracket_open(bracket) || bracket_close(bracket);
}
