#include "all_your_base.h"

size_t rebase(int8_t *input_sequence, int16_t input_base,
              // NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
              int16_t output_base, size_t input_length) {

    // invalid base?
    if (input_base <= 1 || output_base <= 1) {
        return 0;
    }

    // are there invalid numbers in the input sequence?
    for (size_t i = 0; i < input_length; i++) {
        if (input_sequence[i] < 0 || input_sequence[i] >= input_base) {
            return 0;
        }
    }

    int base_ten = 0;

    for (size_t i = 0; i < input_length; i++) {
        // int8_t digit = input_sequence[input_length - 1 - i];
        int8_t digit = input_sequence[i];

        base_ten *= input_base;
        base_ten += digit;
    }

    if (base_ten == 0 && input_length != 0) {
        return 1;
    }

    // we have to modify the input to use a an output
    memset(input_sequence, 0, input_length);

    size_t output_length = 0;

    while (base_ten > 0) {
        input_sequence[output_length] = (int8_t)(base_ten % output_base);
        base_ten /= output_base;

        output_length++;
    }

    for (size_t i = 0, j = output_length; i < (output_length / 2); i++) {
        int8_t temp = input_sequence[i];
        input_sequence[i] = input_sequence[j - i - 1];
        input_sequence[j - i - 1] = temp;
    }

    return output_length;
}
